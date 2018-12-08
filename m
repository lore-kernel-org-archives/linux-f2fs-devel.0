From: Chandan Rajendra <chandan@linux.vnet.ibm.com>
Subject: [PATCH V3 8/9] fsverity: Move verity status check to
 fsverity_file_open
Date: Sat,  8 Dec 2018 12:21:43 +0530
Message-ID: <20181208065144.19486-9-chandan@linux.vnet.ibm.com>
References: <20181208065144.19486-1-chandan@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <chandan@linux.vnet.ibm.com>) id 1gVWUT-0006a1-6o
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 08 Dec 2018 06:53:29 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]
 helo=mx0a-001b2d01.pphosted.com)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1gVWUR-0077e8-SJ
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 08 Dec 2018 06:53:29 +0000
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 wB86mPMo080594
 for <linux-f2fs-devel@lists.sourceforge.net>; Sat, 8 Dec 2018 01:53:22 -0500
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2p87ssaj80-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linux-f2fs-devel@lists.sourceforge.net>; Sat, 08 Dec 2018 01:53:21 -0500
Received: from localhost
 by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linux-f2fs-devel@lists.sourceforge.net> from <chandan@linux.vnet.ibm.com>;
 Sat, 8 Dec 2018 06:53:21 -0000
In-Reply-To: <20181208065144.19486-1-chandan@linux.vnet.ibm.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, linux-doc@vger.kernel.org, linux-mips@linux-mips.org, linux-s390@vger.kernel.org, linux-mtd@lists.infradead.org, linux-fsdevel@vger.kernel.org
Cc: dedekind1@gmail.com, tytso@mit.edu, corbet@lwn.net, jhogan@kernel.org, heiko.carstens@de.ibm.com, adrian.hunter@intel.com, ralf@linux-mips.org, ebiggers@kernel.org, paul.burton@mips.com, adilger.kernel@dilger.ca, green.hu@gmail.com, richard@nod.at, schwidefsky@de.ibm.com, jaegeuk@kernel.org, deanbo422@gmail.com, viro@zeniv.linux.org.uk

Instead of conditionally checking for verity status of an inode before
invoking fsverity_file_open(), this commit moves the check inside the
definition of fsverity_file_open().

Signed-off-by: Chandan Rajendra <chandan@linux.vnet.ibm.com>
---
 fs/ext4/file.c    | 8 +++-----
 fs/f2fs/file.c    | 8 +++-----
 fs/verity/setup.c | 3 +++
 3 files changed, 9 insertions(+), 10 deletions(-)

diff --git a/fs/ext4/file.c b/fs/ext4/file.c
index 30fbd663354f..b404a857cd48 100644
--- a/fs/ext4/file.c
+++ b/fs/ext4/file.c
@@ -444,11 +444,9 @@ static int ext4_file_open(struct inode * inode, struct file * filp)
 	if (ret)
 		return ret;
 
-	if (IS_VERITY(inode)) {
-		ret = fsverity_file_open(inode, filp);
-		if (ret)
-			return ret;
-	}
+	ret = fsverity_file_open(inode, filp);
+	if (ret)
+		return ret;
 
 	/*
 	 * Set up the jbd2_inode if we are opening the inode for
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 2eb4821d95d1..925c0d9608da 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -491,11 +491,9 @@ static int f2fs_file_open(struct inode *inode, struct file *filp)
 	if (err)
 		return err;
 
-	if (IS_VERITY(inode)) {
-		err = fsverity_file_open(inode, filp);
-		if (err)
-			return err;
-	}
+	err = fsverity_file_open(inode, filp);
+	if (err)
+		return err;
 
 	filp->f_mode |= FMODE_NOWAIT;
 
diff --git a/fs/verity/setup.c b/fs/verity/setup.c
index 08b609127531..bc463dc601b1 100644
--- a/fs/verity/setup.c
+++ b/fs/verity/setup.c
@@ -771,6 +771,9 @@ static int setup_fsverity_info(struct inode *inode)
  */
 int fsverity_file_open(struct inode *inode, struct file *filp)
 {
+	if (!IS_VERITY(inode))
+		return 0;
+
 	if (filp->f_mode & FMODE_WRITE) {
 		pr_debug("Denying opening verity file (ino %lu) for write\n",
 			 inode->i_ino);
-- 
2.19.1
