From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: f2fs: add key function to handle inline dir
Date: Tue, 21 Oct 2014 15:53:17 +0300
Message-ID: <20141021125317.GA27182@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <dan.carpenter@oracle.com>) id 1XgYwa-0001l6-TF
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 21 Oct 2014 12:53:44 +0000
Received: from aserp1040.oracle.com ([141.146.126.69])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1XgYwW-0005O7-4v
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 21 Oct 2014 12:53:44 +0000
Content-Disposition: inline
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: chao2.yu@samsung.com
Cc: linux-f2fs-devel@lists.sourceforge.net

Hello Chao Yu,

The patch 9f06d1bb7c87: "f2fs: add key function to handle inline dir"
from Sep 24, 2014, leads to the following static checker warning:

	fs/f2fs/inline.c:358 f2fs_convert_inline_dir()
	error: memcpy() 'dentry_blk->reserved' too small (3 vs 7)

fs/f2fs/inline.c
   355          /* copy data from inline dentry block to new dentry block */
   356          memcpy(dentry_blk->dentry_bitmap, inline_dentry->dentry_bitmap,
   357                                          INLINE_DENTRY_BITMAP_SIZE);
   358          memcpy(dentry_blk->reserved, inline_dentry->reserved,
   359                                          INLINE_RESERVED_SIZE);

This is a harmless buffer overflow because we correct it on the next
line, but dentry_blk->reserved is smaller than inline_dentry->reserved
so we're writing past the end.  We should just be clearing this anyway
instead of copying.

   360          memcpy(dentry_blk->dentry, inline_dentry->dentry,
   361                          sizeof(struct f2fs_dir_entry) * NR_INLINE_DENTRY);
   362          memcpy(dentry_blk->filename, inline_dentry->filename,
   363                                          NR_INLINE_DENTRY * F2FS_SLOT_LEN);
   364  

regards,
dan carpenter

------------------------------------------------------------------------------
Comprehensive Server Monitoring with Site24x7.
Monitor 10 servers for $9/Month.
Get alerted through email, SMS, voice calls or mobile push notifications.
Take corrective actions from your mobile device.
http://p.sf.net/sfu/Zoho
