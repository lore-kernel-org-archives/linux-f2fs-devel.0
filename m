From: Eric Biggers <ebiggers@kernel.org>
Subject: Re: [PATCH 5/7] ext4: use IS_VERITY() to check inode's
 fsverity status
Date: Mon, 26 Nov 2018 16:29:16 -0800
Message-ID: <20181127002915.GC11663@gmail.com>
References: <20181119052324.31456-1-chandan@linux.vnet.ibm.com>
 <20181119052324.31456-6-chandan@linux.vnet.ibm.com>
 <20181126173615.GB22888@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <ebiggers@kernel.org>) id 1gRRFk-0003Wu-Mx
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 27 Nov 2018 00:29:24 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1gRRFj-000xRW-BA
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 27 Nov 2018 00:29:24 +0000
Content-Disposition: inline
In-Reply-To: <20181126173615.GB22888@thunk.org>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: "Theodore Y. Ts'o" <tytso@mit.edu>
Cc: linux-ext4@vger.kernel.org, linux-fscrypt@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

On Mon, Nov 26, 2018 at 12:36:15PM -0500, Theodore Y. Ts'o wrote:
> On Mon, Nov 19, 2018 at 10:53:22AM +0530, Chandan Rajendra wrote:
> > This commit now uses IS_VERITY() macro to check if fsverity is
> > enabled on an inode.
> > 
> > Signed-off-by: Chandan Rajendra <chandan@linux.vnet.ibm.com>
> 
> This patch causes a massive number of fsverity tests.  I suspect it's
> due to a mismatch between the ext4's inode flags as opposed to the VFS
> inode's flags.  I'll take a closer look in the next day or two.
> 
> Cheers,
> 
> 						- Ted

It's missing the following to set S_VERITY during the
FS_IOC_ENABLE_VERITY ioctl:

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index ed933e64e95f..82b45cceb39b 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -1344,6 +1344,11 @@ static int ext4_set_verity(struct inode *inode, loff_t data_i_size)
 	err = ext4_reserve_inode_write(handle, inode, &iloc);
 	if (err == 0) {
 		ext4_set_inode_flag(inode, EXT4_INODE_VERITY);
+		/*
+		 * Update inode->i_flags - S_VERITY will be enabled,
+		 * S_DAX may be disabled
+		 */
+		ext4_set_inode_flags(inode);
 		EXT4_I(inode)->i_disksize = data_i_size;
 		err = ext4_mark_iloc_dirty(handle, inode, &iloc);
 	}
