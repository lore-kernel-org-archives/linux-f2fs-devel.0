From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 203169] crash at fs/f2fs/checkpoint.c:160
 f2fs_is_valid_blkaddr
Date: Sat, 06 Apr 2019 01:35:48 +0000
Message-ID: <bug-203169-202145-9oSjQwU8VO@https.bugzilla.kernel.org/>
References: <bug-203169-202145@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <bugzilla-daemon@bugzilla.kernel.org>)
 id 1hCaFQ-0001pz-Ir
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 06 Apr 2019 01:35:56 +0000
Received: from mail.wl.linuxfoundation.org ([198.145.29.98])
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1hCaFP-003HiC-6r
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 06 Apr 2019 01:35:56 +0000
Received: from mail.wl.linuxfoundation.org (localhost [127.0.0.1])
 by mail.wl.linuxfoundation.org (Postfix) with ESMTP id 066B828B94
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Sat,  6 Apr 2019 01:35:49 +0000 (UTC)
In-Reply-To: <bug-203169-202145@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=203169

--- Comment #1 from Jungyeon (jungyeon@gatech.edu) ---
- Overview
When mounting attached crafted image and making an empty file, I got this
error.

- Produces
mkdir test
mount -t f2fs tmp.img test
cd test
sudo touch t
dmesg

-- 
You are receiving this mail because:
You are watching the assignee of the bug.
