//
//  Copyright (c) 2019 Open Whisper Systems. All rights reserved.
//

import Foundation
import GRDBCipher
import SignalCoreKit

// NOTE: This file is generated by /Scripts/sds_codegen/sds_generate.py.
// Do not manually edit it, instead run `sds_codegen.sh`.

// MARK: - Record

public struct ThreadRecord: SDSRecord {
    public var tableMetadata: SDSTableMetadata {
        return TSThreadSerializer.table
    }

    public static let databaseTableName: String = TSThreadSerializer.table.tableName

    public var id: Int64?

    // This defines all of the columns used in the table
    // where this model (and any subclasses) are persisted.
    public let recordType: SDSRecordType
    public let uniqueId: String

    // Base class properties
    public let archivalDate: Date?
    public let archivedAsOfMessageSortId: Bool?
    public let conversationColorName: String
    public let creationDate: Date?
    public let isArchivedByLegacyTimestampForSorting: Bool
    public let lastMessageDate: Date?
    public let messageDraft: String?
    public let mutedUntilDate: Date?
    public let shouldThreadBeVisible: Bool

    // Subclass properties
    public let contactPhoneNumber: String?
    public let contactThreadSchemaVersion: UInt?
    public let contactUUID: String?
    public let groupModel: Data?

    public enum CodingKeys: String, CodingKey, ColumnExpression, CaseIterable {
        case id
        case recordType
        case uniqueId
        case archivalDate
        case archivedAsOfMessageSortId
        case conversationColorName
        case creationDate
        case isArchivedByLegacyTimestampForSorting
        case lastMessageDate
        case messageDraft
        case mutedUntilDate
        case shouldThreadBeVisible
        case contactPhoneNumber
        case contactThreadSchemaVersion
        case contactUUID
        case groupModel
    }

    public static func columnName(_ column: ThreadRecord.CodingKeys, fullyQualified: Bool = false) -> String {
        return fullyQualified ? "\(databaseTableName).\(column.rawValue)" : column.rawValue
    }
}

// MARK: - StringInterpolation

public extension String.StringInterpolation {
    mutating func appendInterpolation(threadColumn column: ThreadRecord.CodingKeys) {
        appendLiteral(ThreadRecord.columnName(column))
    }
    mutating func appendInterpolation(threadColumnFullyQualified column: ThreadRecord.CodingKeys) {
        appendLiteral(ThreadRecord.columnName(column, fullyQualified: true))
    }
}

// MARK: - Deserialization

// TODO: Rework metadata to not include, for example, columns, column indices.
extension TSThread {
    // This method defines how to deserialize a model, given a
    // database row.  The recordType column is used to determine
    // the corresponding model class.
    class func fromRecord(_ record: ThreadRecord) throws -> TSThread {

        guard let recordId = record.id else {
            throw SDSError.invalidValue
        }

        switch record.recordType {
        case .contactThread:

            let uniqueId: String = record.uniqueId
            let archivalDate: Date? = record.archivalDate
            let archivedAsOfMessageSortId: NSNumber? = SDSDeserialization.optionalNumericAsNSNumber(record.archivedAsOfMessageSortId, name: "archivedAsOfMessageSortId", conversion: { NSNumber(value: $0) })
            let conversationColorName: ConversationColorName = ConversationColorName(rawValue: record.conversationColorName)
            let creationDate: Date? = record.creationDate
            let isArchivedByLegacyTimestampForSorting: Bool = record.isArchivedByLegacyTimestampForSorting
            let lastMessageDate: Date? = record.lastMessageDate
            let messageDraft: String? = record.messageDraft
            let mutedUntilDate: Date? = record.mutedUntilDate
            let rowId: Int64 = Int64(recordId)
            let shouldThreadBeVisible: Bool = record.shouldThreadBeVisible
            let contactPhoneNumber: String? = record.contactPhoneNumber
            let contactThreadSchemaVersion: UInt = try SDSDeserialization.required(record.contactThreadSchemaVersion, name: "contactThreadSchemaVersion")
            let contactUUID: String? = record.contactUUID

            return TSContactThread(uniqueId: uniqueId,
                                   archivalDate: archivalDate,
                                   archivedAsOfMessageSortId: archivedAsOfMessageSortId,
                                   conversationColorName: conversationColorName,
                                   creationDate: creationDate,
                                   isArchivedByLegacyTimestampForSorting: isArchivedByLegacyTimestampForSorting,
                                   lastMessageDate: lastMessageDate,
                                   messageDraft: messageDraft,
                                   mutedUntilDate: mutedUntilDate,
                                   rowId: rowId,
                                   shouldThreadBeVisible: shouldThreadBeVisible,
                                   contactPhoneNumber: contactPhoneNumber,
                                   contactThreadSchemaVersion: contactThreadSchemaVersion,
                                   contactUUID: contactUUID)

        case .groupThread:

            let uniqueId: String = record.uniqueId
            let archivalDate: Date? = record.archivalDate
            let archivedAsOfMessageSortId: NSNumber? = SDSDeserialization.optionalNumericAsNSNumber(record.archivedAsOfMessageSortId, name: "archivedAsOfMessageSortId", conversion: { NSNumber(value: $0) })
            let conversationColorName: ConversationColorName = ConversationColorName(rawValue: record.conversationColorName)
            let creationDate: Date? = record.creationDate
            let isArchivedByLegacyTimestampForSorting: Bool = record.isArchivedByLegacyTimestampForSorting
            let lastMessageDate: Date? = record.lastMessageDate
            let messageDraft: String? = record.messageDraft
            let mutedUntilDate: Date? = record.mutedUntilDate
            let rowId: Int64 = Int64(recordId)
            let shouldThreadBeVisible: Bool = record.shouldThreadBeVisible
            let groupModelSerialized: Data? = record.groupModel
            let groupModel: TSGroupModel = try SDSDeserialization.unarchive(groupModelSerialized, name: "groupModel")

            return TSGroupThread(uniqueId: uniqueId,
                                 archivalDate: archivalDate,
                                 archivedAsOfMessageSortId: archivedAsOfMessageSortId,
                                 conversationColorName: conversationColorName,
                                 creationDate: creationDate,
                                 isArchivedByLegacyTimestampForSorting: isArchivedByLegacyTimestampForSorting,
                                 lastMessageDate: lastMessageDate,
                                 messageDraft: messageDraft,
                                 mutedUntilDate: mutedUntilDate,
                                 rowId: rowId,
                                 shouldThreadBeVisible: shouldThreadBeVisible,
                                 groupModel: groupModel)

        case .thread:

            let uniqueId: String = record.uniqueId
            let archivalDate: Date? = record.archivalDate
            let archivedAsOfMessageSortId: NSNumber? = SDSDeserialization.optionalNumericAsNSNumber(record.archivedAsOfMessageSortId, name: "archivedAsOfMessageSortId", conversion: { NSNumber(value: $0) })
            let conversationColorName: ConversationColorName = ConversationColorName(rawValue: record.conversationColorName)
            let creationDate: Date? = record.creationDate
            let isArchivedByLegacyTimestampForSorting: Bool = record.isArchivedByLegacyTimestampForSorting
            let lastMessageDate: Date? = record.lastMessageDate
            let messageDraft: String? = record.messageDraft
            let mutedUntilDate: Date? = record.mutedUntilDate
            let rowId: Int64 = Int64(recordId)
            let shouldThreadBeVisible: Bool = record.shouldThreadBeVisible

            return TSThread(uniqueId: uniqueId,
                            archivalDate: archivalDate,
                            archivedAsOfMessageSortId: archivedAsOfMessageSortId,
                            conversationColorName: conversationColorName,
                            creationDate: creationDate,
                            isArchivedByLegacyTimestampForSorting: isArchivedByLegacyTimestampForSorting,
                            lastMessageDate: lastMessageDate,
                            messageDraft: messageDraft,
                            mutedUntilDate: mutedUntilDate,
                            rowId: rowId,
                            shouldThreadBeVisible: shouldThreadBeVisible)

        default:
            owsFailDebug("Unexpected record type: \(record.recordType)")
            throw SDSError.invalidValue
        }
    }
}

// MARK: - SDSModel

extension TSThread: SDSModel {
    public var serializer: SDSSerializer {
        // Any subclass can be cast to it's superclass,
        // so the order of this switch statement matters.
        // We need to do a "depth first" search by type.
        switch self {
        case let model as TSGroupThread:
            assert(type(of: model) == TSGroupThread.self)
            return TSGroupThreadSerializer(model: model)
        case let model as TSContactThread:
            assert(type(of: model) == TSContactThread.self)
            return TSContactThreadSerializer(model: model)
        default:
            return TSThreadSerializer(model: self)
        }
    }

    public func asRecord() throws -> SDSRecord {
        return try serializer.asRecord()
    }
}

// MARK: - Table Metadata

extension TSThreadSerializer {

    // This defines all of the columns used in the table
    // where this model (and any subclasses) are persisted.
    static let recordTypeColumn = SDSColumnMetadata(columnName: "recordType", columnType: .int, columnIndex: 0)
    static let idColumn = SDSColumnMetadata(columnName: "id", columnType: .primaryKey, columnIndex: 1)
    static let uniqueIdColumn = SDSColumnMetadata(columnName: "uniqueId", columnType: .unicodeString, columnIndex: 2)
    // Base class properties
    static let archivalDateColumn = SDSColumnMetadata(columnName: "archivalDate", columnType: .int64, isOptional: true, columnIndex: 3)
    static let archivedAsOfMessageSortIdColumn = SDSColumnMetadata(columnName: "archivedAsOfMessageSortId", columnType: .int, isOptional: true, columnIndex: 4)
    static let conversationColorNameColumn = SDSColumnMetadata(columnName: "conversationColorName", columnType: .unicodeString, columnIndex: 5)
    static let creationDateColumn = SDSColumnMetadata(columnName: "creationDate", columnType: .int64, isOptional: true, columnIndex: 6)
    static let isArchivedByLegacyTimestampForSortingColumn = SDSColumnMetadata(columnName: "isArchivedByLegacyTimestampForSorting", columnType: .int, columnIndex: 7)
    static let lastMessageDateColumn = SDSColumnMetadata(columnName: "lastMessageDate", columnType: .int64, isOptional: true, columnIndex: 8)
    static let messageDraftColumn = SDSColumnMetadata(columnName: "messageDraft", columnType: .unicodeString, isOptional: true, columnIndex: 9)
    static let mutedUntilDateColumn = SDSColumnMetadata(columnName: "mutedUntilDate", columnType: .int64, isOptional: true, columnIndex: 10)
    static let shouldThreadBeVisibleColumn = SDSColumnMetadata(columnName: "shouldThreadBeVisible", columnType: .int, columnIndex: 11)
    // Subclass properties
    static let contactPhoneNumberColumn = SDSColumnMetadata(columnName: "contactPhoneNumber", columnType: .unicodeString, isOptional: true, columnIndex: 12)
    static let contactThreadSchemaVersionColumn = SDSColumnMetadata(columnName: "contactThreadSchemaVersion", columnType: .int64, isOptional: true, columnIndex: 13)
    static let contactUUIDColumn = SDSColumnMetadata(columnName: "contactUUID", columnType: .unicodeString, isOptional: true, columnIndex: 14)
    static let groupModelColumn = SDSColumnMetadata(columnName: "groupModel", columnType: .blob, isOptional: true, columnIndex: 15)

    // TODO: We should decide on a naming convention for
    //       tables that store models.
    public static let table = SDSTableMetadata(tableName: "model_TSThread", columns: [
        recordTypeColumn,
        idColumn,
        uniqueIdColumn,
        archivalDateColumn,
        archivedAsOfMessageSortIdColumn,
        conversationColorNameColumn,
        creationDateColumn,
        isArchivedByLegacyTimestampForSortingColumn,
        lastMessageDateColumn,
        messageDraftColumn,
        mutedUntilDateColumn,
        shouldThreadBeVisibleColumn,
        contactPhoneNumberColumn,
        contactThreadSchemaVersionColumn,
        contactUUIDColumn,
        groupModelColumn
        ])
}

// MARK: - Save/Remove/Update

@objc
public extension TSThread {
    func anyInsert(transaction: SDSAnyWriteTransaction) {
        sdsSave(saveMode: .insert, transaction: transaction)
    }

    // This method is private; we should never use it directly.
    // Instead, use anyUpdate(transaction:block:), so that we
    // use the "update with" pattern.
    private func anyUpdate(transaction: SDSAnyWriteTransaction) {
        sdsSave(saveMode: .update, transaction: transaction)
    }

    @available(*, deprecated, message: "Use anyInsert() or anyUpdate() instead.")
    func anyUpsert(transaction: SDSAnyWriteTransaction) {
        let isInserting: Bool
        if TSThread.anyFetch(uniqueId: uniqueId, transaction: transaction) != nil {
            isInserting = false
        } else {
            isInserting = true
        }
        sdsSave(saveMode: isInserting ? .insert : .update, transaction: transaction)
    }

    // This method is used by "updateWith..." methods.
    //
    // This model may be updated from many threads. We don't want to save
    // our local copy (this instance) since it may be out of date.  We also
    // want to avoid re-saving a model that has been deleted.  Therefore, we
    // use "updateWith..." methods to:
    //
    // a) Update a property of this instance.
    // b) If a copy of this model exists in the database, load an up-to-date copy,
    //    and update and save that copy.
    // b) If a copy of this model _DOES NOT_ exist in the database, do _NOT_ save
    //    this local instance.
    //
    // After "updateWith...":
    //
    // a) Any copy of this model in the database will have been updated.
    // b) The local property on this instance will always have been updated.
    // c) Other properties on this instance may be out of date.
    //
    // All mutable properties of this class have been made read-only to
    // prevent accidentally modifying them directly.
    //
    // This isn't a perfect arrangement, but in practice this will prevent
    // data loss and will resolve all known issues.
    func anyUpdate(transaction: SDSAnyWriteTransaction, block: (TSThread) -> Void) {

        block(self)

        guard let dbCopy = type(of: self).anyFetch(uniqueId: uniqueId,
                                                   transaction: transaction) else {
            return
        }

        // Don't apply the block twice to the same instance.
        // It's at least unnecessary and actually wrong for some blocks.
        // e.g. `block: { $0 in $0.someField++ }`
        if dbCopy !== self {
            block(dbCopy)
        }

        dbCopy.anyUpdate(transaction: transaction)
    }

    func anyRemove(transaction: SDSAnyWriteTransaction) {
        guard shouldBeSaved else {
            // Skipping remove.
            return
        }

        anyWillRemove(with: transaction)

        switch transaction.writeTransaction {
        case .yapWrite(let ydbTransaction):
            ydb_remove(with: ydbTransaction)
        case .grdbWrite(let grdbTransaction):
            do {
                let record = try asRecord()
                record.sdsRemove(transaction: grdbTransaction)
            } catch {
                owsFail("Remove failed: \(error)")
            }
        }

        anyDidRemove(with: transaction)
    }

    func anyReload(transaction: SDSAnyReadTransaction) {
        anyReload(transaction: transaction, ignoreMissing: false)
    }

    func anyReload(transaction: SDSAnyReadTransaction, ignoreMissing: Bool) {
        guard let latestVersion = type(of: self).anyFetch(uniqueId: uniqueId, transaction: transaction) else {
            if !ignoreMissing {
                owsFailDebug("`latest` was unexpectedly nil")
            }
            return
        }

        setValuesForKeys(latestVersion.dictionaryValue)
    }
}

// MARK: - TSThreadCursor

@objc
public class TSThreadCursor: NSObject {
    private let cursor: RecordCursor<ThreadRecord>?

    init(cursor: RecordCursor<ThreadRecord>?) {
        self.cursor = cursor
    }

    public func next() throws -> TSThread? {
        guard let cursor = cursor else {
            return nil
        }
        guard let record = try cursor.next() else {
            return nil
        }
        return try TSThread.fromRecord(record)
    }

    public func all() throws -> [TSThread] {
        var result = [TSThread]()
        while true {
            guard let model = try next() else {
                break
            }
            result.append(model)
        }
        return result
    }
}

// MARK: - Obj-C Fetch

// TODO: We may eventually want to define some combination of:
//
// * fetchCursor, fetchOne, fetchAll, etc. (ala GRDB)
// * Optional "where clause" parameters for filtering.
// * Async flavors with completions.
//
// TODO: I've defined flavors that take a read transaction.
//       Or we might take a "connection" if we end up having that class.
@objc
public extension TSThread {
    class func grdbFetchCursor(transaction: GRDBReadTransaction) -> TSThreadCursor {
        let database = transaction.database
        do {
            let cursor = try ThreadRecord.fetchCursor(database)
            return TSThreadCursor(cursor: cursor)
        } catch {
            owsFailDebug("Read failed: \(error)")
            return TSThreadCursor(cursor: nil)
        }
    }

    // Fetches a single model by "unique id".
    class func anyFetch(uniqueId: String,
                        transaction: SDSAnyReadTransaction) -> TSThread? {
        assert(uniqueId.count > 0)

        switch transaction.readTransaction {
        case .yapRead(let ydbTransaction):
            return TSThread.ydb_fetch(uniqueId: uniqueId, transaction: ydbTransaction)
        case .grdbRead(let grdbTransaction):
            let sql = "SELECT * FROM \(ThreadRecord.databaseTableName) WHERE \(threadColumn: .uniqueId) = ?"
            return grdbFetchOne(sql: sql, arguments: [uniqueId], transaction: grdbTransaction)
        }
    }

    // Traverses all records.
    // Records are not visited in any particular order.
    // Traversal aborts if the visitor returns false.
    class func anyEnumerate(transaction: SDSAnyReadTransaction, block: @escaping (TSThread, UnsafeMutablePointer<ObjCBool>) -> Void) {
        switch transaction.readTransaction {
        case .yapRead(let ydbTransaction):
            TSThread.ydb_enumerateCollectionObjects(with: ydbTransaction) { (object, stop) in
                guard let value = object as? TSThread else {
                    owsFailDebug("unexpected object: \(type(of: object))")
                    return
                }
                block(value, stop)
            }
        case .grdbRead(let grdbTransaction):
            do {
                let cursor = TSThread.grdbFetchCursor(transaction: grdbTransaction)
                var stop: ObjCBool = false
                while let value = try cursor.next() {
                    block(value, &stop)
                    guard !stop.boolValue else {
                        break
                    }
                }
            } catch let error as NSError {
                owsFailDebug("Couldn't fetch models: \(error)")
            }
        }
    }

    // Traverses all records' unique ids.
    // Records are not visited in any particular order.
    // Traversal aborts if the visitor returns false.
    class func anyEnumerateUniqueIds(transaction: SDSAnyReadTransaction, block: @escaping (String, UnsafeMutablePointer<ObjCBool>) -> Void) {
        switch transaction.readTransaction {
        case .yapRead(let ydbTransaction):
            ydbTransaction.enumerateKeys(inCollection: TSThread.collection()) { (uniqueId, stop) in
                block(uniqueId, stop)
            }
        case .grdbRead(let grdbTransaction):
            grdbEnumerateUniqueIds(transaction: grdbTransaction,
                                   sql: """
                    SELECT \(threadColumn: .uniqueId)
                    FROM \(ThreadRecord.databaseTableName)
                """,
                block: block)
        }
    }

    // Does not order the results.
    class func anyFetchAll(transaction: SDSAnyReadTransaction) -> [TSThread] {
        var result = [TSThread]()
        anyEnumerate(transaction: transaction) { (model, _) in
            result.append(model)
        }
        return result
    }

    // Does not order the results.
    class func anyAllUniqueIds(transaction: SDSAnyReadTransaction) -> [String] {
        var result = [String]()
        anyEnumerateUniqueIds(transaction: transaction) { (uniqueId, _) in
            result.append(uniqueId)
        }
        return result
    }

    class func anyCount(transaction: SDSAnyReadTransaction) -> UInt {
        switch transaction.readTransaction {
        case .yapRead(let ydbTransaction):
            return ydbTransaction.numberOfKeys(inCollection: TSThread.collection())
        case .grdbRead(let grdbTransaction):
            return ThreadRecord.ows_fetchCount(grdbTransaction.database)
        }
    }

    // WARNING: Do not use this method for any models which do cleanup
    //          in their anyWillRemove(), anyDidRemove() methods.
    class func anyRemoveAllWithoutInstantation(transaction: SDSAnyWriteTransaction) {
        switch transaction.writeTransaction {
        case .yapWrite(let ydbTransaction):
            ydbTransaction.removeAllObjects(inCollection: TSThread.collection())
        case .grdbWrite(let grdbTransaction):
            do {
                try ThreadRecord.deleteAll(grdbTransaction.database)
            } catch {
                owsFailDebug("deleteAll() failed: \(error)")
            }
        }
    }

    class func anyRemoveAllWithInstantation(transaction: SDSAnyWriteTransaction) {
        anyEnumerate(transaction: transaction) { (instance, _) in
            instance.anyRemove(transaction: transaction)
        }
    }
}

// MARK: - Swift Fetch

public extension TSThread {
    class func grdbFetchCursor(sql: String,
                               arguments: [DatabaseValueConvertible]?,
                               transaction: GRDBReadTransaction) -> TSThreadCursor {
        var statementArguments: StatementArguments?
        if let arguments = arguments {
            guard let statementArgs = StatementArguments(arguments) else {
                owsFailDebug("Could not convert arguments.")
                return TSThreadCursor(cursor: nil)
            }
            statementArguments = statementArgs
        }
        let database = transaction.database
        do {
            let statement: SelectStatement = try database.cachedSelectStatement(sql: sql)
            let cursor = try ThreadRecord.fetchCursor(statement, arguments: statementArguments)
            return TSThreadCursor(cursor: cursor)
        } catch {
            Logger.error("sql: \(sql)")
            owsFailDebug("Read failed: \(error)")
            return TSThreadCursor(cursor: nil)
        }
    }

    class func grdbFetchOne(sql: String,
                            arguments: StatementArguments,
                            transaction: GRDBReadTransaction) -> TSThread? {
        assert(sql.count > 0)

        do {
            guard let record = try ThreadRecord.fetchOne(transaction.database, sql: sql, arguments: arguments) else {
                return nil
            }

            return try TSThread.fromRecord(record)
        } catch {
            owsFailDebug("error: \(error)")
            return nil
        }
    }
}

// MARK: - SDSSerializer

// The SDSSerializer protocol specifies how to insert and update the
// row that corresponds to this model.
class TSThreadSerializer: SDSSerializer {

    private let model: TSThread
    public required init(model: TSThread) {
        self.model = model
    }

    // MARK: - Record

    func asRecord() throws -> SDSRecord {
        let id: Int64? = nil

        let recordType: SDSRecordType = .thread
        let uniqueId: String = model.uniqueId

        // Base class properties
        let archivalDate: Date? = model.archivalDate
        let archivedAsOfMessageSortId: Bool? = archiveOptionalNSNumber(model.archivedAsOfMessageSortId, conversion: { $0.boolValue })
        let conversationColorName: String = model.conversationColorName.rawValue
        let creationDate: Date? = model.creationDate
        let isArchivedByLegacyTimestampForSorting: Bool = model.isArchivedByLegacyTimestampForSorting
        let lastMessageDate: Date? = model.lastMessageDate
        let messageDraft: String? = model.messageDraft
        let mutedUntilDate: Date? = model.mutedUntilDate
        let shouldThreadBeVisible: Bool = model.shouldThreadBeVisible

        // Subclass properties
        let contactPhoneNumber: String? = nil
        let contactThreadSchemaVersion: UInt? = nil
        let contactUUID: String? = nil
        let groupModel: Data? = nil

        return ThreadRecord(id: id, recordType: recordType, uniqueId: uniqueId, archivalDate: archivalDate, archivedAsOfMessageSortId: archivedAsOfMessageSortId, conversationColorName: conversationColorName, creationDate: creationDate, isArchivedByLegacyTimestampForSorting: isArchivedByLegacyTimestampForSorting, lastMessageDate: lastMessageDate, messageDraft: messageDraft, mutedUntilDate: mutedUntilDate, shouldThreadBeVisible: shouldThreadBeVisible, contactPhoneNumber: contactPhoneNumber, contactThreadSchemaVersion: contactThreadSchemaVersion, contactUUID: contactUUID, groupModel: groupModel)
    }
}
