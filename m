From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 201911] New: High frequency of gc cause application
 database corrupt
Date: Fri, 07 Dec 2018 02:38:40 +0000
Message-ID: <bug-201911-202145@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <bugzilla-daemon@bugzilla.kernel.org>)
 id 1gV62S-0004YN-Iq
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 07 Dec 2018 02:38:48 +0000
Received: from mail.wl.linuxfoundation.org ([198.145.29.98])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1gV62Q-005OfS-N4
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 07 Dec 2018 02:38:48 +0000
Received: from mail.wl.linuxfoundation.org (localhost [127.0.0.1])
 by mail.wl.linuxfoundation.org (Postfix) with ESMTP id 1B9F22D175
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri,  7 Dec 2018 02:38:40 +0000 (UTC)
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: linux-f2fs-devel@lists.sourceforge.net

https://bugzilla.kernel.org/show_bug.cgi?id=201911

            Bug ID: 201911
           Summary: High frequency of gc cause application database
                    corrupt
           Product: File System
           Version: 2.5
    Kernel Version: 4.9
          Hardware: ARM
                OS: Linux
              Tree: Mainline
            Status: NEW
          Severity: high
          Priority: P1
         Component: f2fs
          Assignee: filesystem_f2fs@kernel-bugs.kernel.org
          Reporter: liu_shuang_lin@163.com
        Regression: No

Hello, 

Android phone with kernel 4.9, f2fs version based on 2018-06-04 version with
commit description "f2fs: run fstrim asynchronously if runtime discard is on",

fill 2G space totaly, with a 4K small file each, and then delete 1G,

set gc_urgent_sleep_time to 300, and gc_urgent to 1.

then do monkey test,

40% cause application database corrupt, below is main log error info: 

----------------------------------------
11-25 21:42:27.874 21412 21412 W System.err: Application uncaught exception in
thread "main" com.tencent.wcdb.database.SQLiteDatabaseCorruptException:
database disk image is malformed (code 11, errno 0): 
11-25 21:42:27.874 21412 21412 W System.err:    at
com.tencent.wcdb.database.SQLiteConnection.nativeExecuteForLastInsertedRowId(Native
Method)
11-25 21:42:27.874 21412 21412 W System.err:    at
com.tencent.wcdb.database.SQLiteConnection.executeForLastInsertedRowId(SourceFile:887)
11-25 21:42:27.874 21412 21412 W System.err:    at
com.tencent.wcdb.database.SQLiteSession.executeForLastInsertedRowId(SourceFile:742)
11-25 21:42:27.874 21412 21412 W System.err:    at
com.tencent.wcdb.database.SQLiteStatement.executeInsert(SourceFile:127)
11-25 21:42:27.874 21412 21412 W System.err:    at
com.tencent.wcdb.database.SQLiteStatement.executeInsert(SourceFile:110)
11-25 21:42:27.874 21412 21412 W System.err:    at
com.tencent.wcdb.database.SQLiteDatabase.insertWithOnConflict(SourceFile:1678)
11-25 21:42:27.874 21412 21412 W System.err:    at
com.tencent.wcdb.database.SQLiteDatabase.insert(SourceFile:1528)
11-25 21:42:27.874 21412 21412 W System.err:    at
com.tencent.mm.cg.f.insert(SourceFile:645)
11-25 21:42:27.874 21412 21412 W System.err:    at
com.tencent.mm.cg.h.a(SourceFile:561)
11-25 21:42:27.874 21412 21412 W System.err:    at
com.tencent.mm.storage.bj.b(SourceFile:1583)
11-25 21:42:27.874 21412 21412 W System.err:    at
com.tencent.mm.modelmulti.h.<init>(SourceFile:120)
11-25 21:42:27.874 21412 21412 W System.err:    at
com.tencent.mm.ui.chatting.b.ah$1.run(SourceFile:176)
11-25 21:42:27.874 21412 21412 W System.err:    at
com.tencent.mm.sdk.platformtools.ao.run(SourceFile:127)
11-25 21:42:27.874 21412 21412 W System.err:    at
android.os.Handler.handleCallback(Handler.java:873)
11-25 21:42:27.874 21412 21412 W System.err:    at
android.os.Handler.dispatchMessage(Handler.java:99)
11-25 21:42:27.874 21412 21412 W System.err:    at
com.tencent.mm.sdk.platformtools.aj.dispatchMessage(SourceFile:122)
11-25 21:42:27.874 21412 21412 W System.err:    at
android.os.Looper.loop(Looper.java:217)
11-25 21:42:27.874 21412 21412 W System.err:    at
android.app.ActivityThread.main(ActivityThread.java:7351)
11-25 21:42:27.874 21412 21412 W System.err:    at
java.lang.reflect.Method.invoke(Native Method)
11-25 21:42:27.874 21412 21412 W System.err:    at
com.android.internal.os.RuntimeInit$MethodAndArgsCaller.run(RuntimeInit.java:499)
11-25 21:42:27.874 21412 21412 W System.err:    at
com.android.internal.os.ZygoteInit.main(ZygoteInit.java:865)

----------------------------------------

in comparison, if decrease gc frequency, the corrupt frequency also decreased.

-- 
You are receiving this mail because:
You are watching the assignee of the bug.
