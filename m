From: Chao Yu <chao@kernel.org>
Subject: Re: [bug report] f2fs: fix to avoid reading out
 encrypted data in page cache
Date: Tue, 12 Jul 2016 23:15:07 +0800
Message-ID: <04413f72-1c7c-7a87-5746-08dc3d9f362f@kernel.org>
References: <20160712132938.GA20260@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chao@kernel.org>) id 1bMzPD-0002OJ-GQ
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 12 Jul 2016 15:15:27 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1bMzPC-00014b-F4
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 12 Jul 2016 15:15:27 +0000
In-Reply-To: <20160712132938.GA20260@mwanda>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Dan Carpenter <dan.carpenter@oracle.com>, yuchao0@huawei.com
Cc: linux-f2fs-devel@lists.sourceforge.net

Hi Dan,

Thanks for your report, please check v2.

Thanks,

On 2016/7/12 21:29, Dan Carpenter wrote:
> Hello Chao Yu,
> 
> The patch 78682f794479: "f2fs: fix to avoid reading out encrypted
> data in page cache" from Jul 3, 2016, leads to the following static
> checker warning:
> 
> 	fs/f2fs/data.c:1123 f2fs_mpage_readpages()
> 	error: 'bio' dereferencing possible ERR_PTR()
> 
> fs/f2fs/data.c
>   1093                  }
>   1094                  if (bio == NULL) {
>   1095                          bio = f2fs_grab_bio(inode, block_nr, nr_pages);
>   1096                          if (IS_ERR(bio))
>                                     ^^^^^^^^^^
> It's an error pointer.
> 
>   1097                                  goto set_error_page;
>   1098                          bio_set_op_attrs(bio, REQ_OP_READ, 0);
>   1099                  }
>   1100  
>   1101                  if (bio_add_page(bio, page, blocksize, 0) < blocksize)
>   1102                          goto submit_and_realloc;
>   1103  
>   1104                  last_block_in_bio = block_nr;
>   1105                  goto next_page;
>   1106  set_error_page:
>   1107                  SetPageError(page);
>   1108                  zero_user_segment(page, 0, PAGE_SIZE);
>   1109                  unlock_page(page);
>   1110                  goto next_page;
>   1111  confused:
>   1112                  if (bio) {
>   1113                          __submit_bio(F2FS_I_SB(inode), bio, DATA);
>   1114                          bio = NULL;
>   1115                  }
>   1116                  unlock_page(page);
>   1117  next_page:
>   1118                  if (pages)
>   1119                          put_page(page);
>   1120          }
>   1121          BUG_ON(pages && !list_empty(pages));
>   1122          if (bio)
>   1123                  __submit_bio(F2FS_I_SB(inode), bio, DATA);
>                                                        ^^^
> Dereferenced.
> 
>   1124          return 0;
> 
> regards,
> dan carpenter
> 
> ------------------------------------------------------------------------------
> What NetFlow Analyzer can do for you? Monitors network bandwidth and traffic
> patterns at an interface-level. Reveals which users, apps, and protocols are 
> consuming the most bandwidth. Provides multi-vendor support for NetFlow, 
> J-Flow, sFlow and other flows. Make informed decisions using capacity planning
> reports.http://sdm.link/zohodev2dev
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
> 

------------------------------------------------------------------------------
What NetFlow Analyzer can do for you? Monitors network bandwidth and traffic
patterns at an interface-level. Reveals which users, apps, and protocols are 
consuming the most bandwidth. Provides multi-vendor support for NetFlow, 
J-Flow, sFlow and other flows. Make informed decisions using capacity planning
reports.http://sdm.link/zohodev2dev
