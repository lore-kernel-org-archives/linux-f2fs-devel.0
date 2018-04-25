From: Jayashree Mohan <jayashree2912@gmail.com>
Subject: Lack of strictly ordered metadata crash recovery in f2fs
Date: Tue, 24 Apr 2018 22:07:59 -0500
Message-ID: <CA+EzBbCxHTeuNWU5M3wrtyYBmpcjgUGbfkNKysX5iVKivg6u3A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <jayashree2912@gmail.com>) id 1fBAmt-0000aW-L6
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 25 Apr 2018 03:08:07 +0000
Received: from mail-ua0-f170.google.com ([209.85.217.170])
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.90_1)
 id 1fBAms-00Atl8-27
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 25 Apr 2018 03:08:07 +0000
Received: by mail-ua0-f170.google.com with SMTP id a17so13976554uaf.13
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 24 Apr 2018 20:08:05 -0700 (PDT)
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
Cc: Vijaychidambaram Velayudhan Pillai <vijay@cs.utexas.edu>

Hi,

While testing filesystems for crash consistency, we came across a
workload that could demonstrate that f2fs lacks strictly ordered
metadata behavior.

Workload:

mkdir A
sync()
rename(A, B)
creat (B/foo)
fsync (B/foo)
---crash---

For a strictly ordered metadata filesystem, if we fsync a file, then
all previous transactions that are required to reference this file
must also be committed. Going by this logic, fsync(B/foo) should have
persisted the rename operation and the directory B itself. ext4 and
xfs correctly resolve all dependencies and on recovery from a crash,
we see both directory B and B/foo i.e. the contents of directory are:
dir A : does not exist
dir B:
    foo

However in f2fs, on recovery we see:
dir A :
    foo
dir B : does not exist

This seems to be an incorrect state to recover to, because the file
foo was created in directory B after the rename operation and we
incorrectly see the entry in directory A.

However, if we tweak the workload to not have a sync, i.e
mkdir A
rename(A, B)
creat (B/foo)
fsync (B/foo)
---crash---

then, the file B/foo and directory B are persisted. We don't seem to
understand the reason for this behaviour.

We understand that POSIX requires fsync on directory B to persist the
rename operation, and f2fs does persist the entries if we sync the
directory, however most filesystems(ext4, xfs) provide much higher
guarantees when it comes to crash consistency.

If F2FS classifies itself as a filesystem that provides ordered
metadata behaviour, shouldn't it correctly persist the rename in this
case? Let us know what you think about this inconsistent behaviour.

Thanks,
Jayashree Mohan

------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
