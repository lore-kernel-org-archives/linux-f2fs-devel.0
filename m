From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: f2fs: reorganize f2fs_map_blocks
Date: Mon, 21 Sep 2015 19:25:08 +0300
Message-ID: <20150921162508.GD5648@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <dan.carpenter@oracle.com>) id 1Ze3uG-00085k-Ae
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 21 Sep 2015 16:25:32 +0000
Received: from userp1040.oracle.com ([156.151.31.81])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Ze3uC-0004zV-9V
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 21 Sep 2015 16:25:32 +0000
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

The patch bce86a6c64a7: "f2fs: reorganize f2fs_map_blocks" from Sep
11, 2015, leads to the following static checker warning:

	fs/f2fs/data.c:653 f2fs_map_blocks()
	warn: was || intended here instead of &&?

fs/f2fs/data.c
   650          if (maxblocks > map->m_len) {
   651                  block_t blkaddr = datablock_addr(dn.node_page, dn.ofs_in_node);
   652  
   653                  if (blkaddr == NEW_ADDR && blkaddr == NULL_ADDR) {
                            ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
Impossible condition.

   654                          if (create) {
   655                                  err = __allocate_data_block(&dn);
   656                                  if (err)
   657                                          goto sync_out;
   658                                  allocated = true;
   659                                  map->m_flags |= F2FS_MAP_NEW;
   660                                  blkaddr = dn.data_blkaddr;
   661                          } else {
   662                                  /*
   663                                   * we only merge preallocated unwritten blocks
   664                                   * for fiemap.
   665                                   */
   666                                  if (flag != F2FS_GET_BLOCK_FIEMAP ||
   667                                                  blkaddr != NEW_ADDR)
   668                                          goto sync_out;
   669                          }
   670                  }

regards,
dan carpenter

------------------------------------------------------------------------------
