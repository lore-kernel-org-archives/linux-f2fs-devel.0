From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: f2fs: reorganize f2fs_map_blocks
Date: Mon, 21 Sep 2015 11:43:39 -0700
Message-ID: <20150921184339.GB20551@jaegeuk-mac02.mot.com>
References: <20150921162508.GD5648@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1Ze63v-0006dA-DY
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 21 Sep 2015 18:43:39 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1Ze63t-0004nh-JK for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 21 Sep 2015 18:43:39 +0000
Content-Disposition: inline
In-Reply-To: <20150921162508.GD5648@mwanda>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: linux-f2fs-devel@lists.sourceforge.net

Hi Dan,

New patch was already introduced before. :)
I'm too lazy to rebase that patch.
Sorry for the confusion.

Thanks,

On Mon, Sep 21, 2015 at 07:25:08PM +0300, Dan Carpenter wrote:
> Hello Chao Yu,
> 
> The patch bce86a6c64a7: "f2fs: reorganize f2fs_map_blocks" from Sep
> 11, 2015, leads to the following static checker warning:
> 
> 	fs/f2fs/data.c:653 f2fs_map_blocks()
> 	warn: was || intended here instead of &&?
> 
> fs/f2fs/data.c
>    650          if (maxblocks > map->m_len) {
>    651                  block_t blkaddr = datablock_addr(dn.node_page, dn.ofs_in_node);
>    652  
>    653                  if (blkaddr == NEW_ADDR && blkaddr == NULL_ADDR) {
>                             ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> Impossible condition.
> 
>    654                          if (create) {
>    655                                  err = __allocate_data_block(&dn);
>    656                                  if (err)
>    657                                          goto sync_out;
>    658                                  allocated = true;
>    659                                  map->m_flags |= F2FS_MAP_NEW;
>    660                                  blkaddr = dn.data_blkaddr;
>    661                          } else {
>    662                                  /*
>    663                                   * we only merge preallocated unwritten blocks
>    664                                   * for fiemap.
>    665                                   */
>    666                                  if (flag != F2FS_GET_BLOCK_FIEMAP ||
>    667                                                  blkaddr != NEW_ADDR)
>    668                                          goto sync_out;
>    669                          }
>    670                  }
> 
> regards,
> dan carpenter
> 
> ------------------------------------------------------------------------------
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

------------------------------------------------------------------------------
