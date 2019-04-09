From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 203211] New: Infinite error messages on mounting
 crafted image
Date: Tue, 09 Apr 2019 20:11:36 +0000
Message-ID: <bug-203211-202145@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <bugzilla-daemon@bugzilla.kernel.org>)
 id 1hDx5s-0002Nn-CH
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 09 Apr 2019 20:11:44 +0000
Received: from mail.wl.linuxfoundation.org ([198.145.29.98])
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1hDx5r-00CQm5-1A
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 09 Apr 2019 20:11:44 +0000
Received: from mail.wl.linuxfoundation.org (localhost [127.0.0.1])
 by mail.wl.linuxfoundation.org (Postfix) with ESMTP id 632DF289E8
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue,  9 Apr 2019 20:11:37 +0000 (UTC)
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

https://bugzilla.kernel.org/show_bug.cgi?id=203211

            Bug ID: 203211
           Summary: Infinite error messages on mounting crafted image
           Product: File System
           Version: 2.5
    Kernel Version: 5.0.0
          Hardware: All
                OS: Linux
              Tree: Mainline
            Status: NEW
          Severity: normal
          Priority: P1
         Component: f2fs
          Assignee: filesystem_f2fs@kernel-bugs.kernel.org
          Reporter: jungyeon@gatech.edu
        Regression: No

Created attachment 282203
  --> https://bugzilla.kernel.org/attachment.cgi?id=282203&action=edit
The (compressed) crafted image which causes crash

- Overview
When mounting the attached crafted image and making a new file, I got this
error and the error messages keep repeating. 

The image is intentionally fuzzed from a normal f2fs image for testing and I
run with option CONFIG_F2FS_CHECK_FS on.

- Reproduces
mkdir test
mount -t f2fs tmp.img test
cd test
touch t

- Messages
[   58.820451] F2FS-fs (sdb): Inconsistent segment (1) type [1, 0] in SSA and
SIT
[   58.821485] F2FS-fs (sdb): Inconsistent segment (1) type [1, 0] in SSA and
SIT
[   58.822530] F2FS-fs (sdb): Inconsistent segment (1) type [1, 0] in SSA and
SIT
[   58.823571] F2FS-fs (sdb): Inconsistent segment (1) type [1, 0] in SSA and
SIT
[   58.824616] F2FS-fs (sdb): Inconsistent segment (1) type [1, 0] in SSA and
SIT
[   58.825640] F2FS-fs (sdb): Inconsistent segment (1) type [1, 0] in SSA and
SIT
[   58.826663] F2FS-fs (sdb): Inconsistent segment (1) type [1, 0] in SSA and
SIT
[   58.827698] F2FS-fs (sdb): Inconsistent segment (1) type [1, 0] in SSA and
SIT
[   58.828719] F2FS-fs (sdb): Inconsistent segment (1) type [1, 0] in SSA and
SIT
[   58.829759] F2FS-fs (sdb): Inconsistent segment (1) type [1, 0] in SSA and
SIT
[   58.830783] F2FS-fs (sdb): Inconsistent segment (1) type [1, 0] in SSA and
SIT
[   58.831828] F2FS-fs (sdb): Inconsistent segment (1) type [1, 0] in SSA and
SIT
[   58.832869] F2FS-fs (sdb): Inconsistent segment (1) type [1, 0] in SSA and
SIT
[   58.833888] F2FS-fs (sdb): Inconsistent segment (1) type [1, 0] in SSA and
SIT
[   58.834945] F2FS-fs (sdb): Inconsistent segment (1) type [1, 0] in SSA and
SIT
[   58.835996] F2FS-fs (sdb): Inconsistent segment (1) type [1, 0] in SSA and
SIT
[   58.837028] F2FS-fs (sdb): Inconsistent segment (1) type [1, 0] in SSA and
SIT
[   58.838051] F2FS-fs (sdb): Inconsistent segment (1) type [1, 0] in SSA and
SIT
[   58.839072] F2FS-fs (sdb): Inconsistent segment (1) type [1, 0] in SSA and
SIT
[   58.840100] F2FS-fs (sdb): Inconsistent segment (1) type [1, 0] in SSA and
SIT
[   58.841147] F2FS-fs (sdb): Inconsistent segment (1) type [1, 0] in SSA and
SIT
[   58.842186] F2FS-fs (sdb): Inconsistent segment (1) type [1, 0] in SSA and
SIT
[   58.843214] F2FS-fs (sdb): Inconsistent segment (1) type [1, 0] in SSA and
SIT
[   58.844267] F2FS-fs (sdb): Inconsistent segment (1) type [1, 0] in SSA and
SIT
[   58.845282] F2FS-fs (sdb): Inconsistent segment (1) type [1, 0] in SSA and
SIT
[   58.846305] F2FS-fs (sdb): Inconsistent segment (1) type [1, 0] in SSA and
SIT
[   58.847341] F2FS-fs (sdb): Inconsistent segment (1) type [1, 0] in SSA and
SIT
... (repeating)

-- 
You are receiving this mail because:
You are watching the assignee of the bug.
