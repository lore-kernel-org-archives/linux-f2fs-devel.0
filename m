From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH] f2fs: prevent newly created inode from being
 dirtied incorrectly
Date: Thu, 11 Jan 2018 17:52:38 +0800
Message-ID: <3a679d9e-8beb-8e65-d96a-e0850ca7fa4d@huawei.com>
References: <CGME20180111022559epcas2p4b188916d6259160ed9648c9265ce2c8a@epcas2p4.samsung.com>
 <1515637579-8360-1-git-send-email-daeho.jeong@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.191]
 helo=mx.sourceforge.net)
 by sfs-ml-3.v29.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 (envelope-from <yuchao0@huawei.com>) id 1eZZXi-0005oo-2w
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 11 Jan 2018 09:53:02 +0000
Received: from [45.249.212.32] (helo=huawei.com)
 by sfi-mx-1.v28.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 id 1eZZXg-0006b8-PX
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 11 Jan 2018 09:53:02 +0000
In-Reply-To: <1515637579-8360-1-git-send-email-daeho.jeong@samsung.com>
Content-Language: en-US
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Daeho Jeong <daeho.jeong@samsung.com>, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

On 2018/1/11 10:26, Daeho Jeong wrote:
> Now, we invoke f2fs_mark_inode_dirty_sync() to make an inode dirty in
> advance of creating a new node page for the inode. By this, some inodes
> whose node page is not created yet can be linked into the global dirty
> list.
> 
> If the checkpoint is executed at this moment, the inode will be written
> back by writeback_single_inode() and finally update_inode_page() will
> fail to detach the inode from the global dirty list because the inode
> doesn't have a node page.
> 
> The problem is that the inode's state in VFS layer will become clean
> after execution of writeback_single_inode() and it's still linked in
> the global dirty list of f2fs and this will cause a kernel panic.
> 
> So, we will prevent the newly created inode from being dirtied during
> the FI_NEW_INODE flag of the inode is set. We will make it dirty
> right after the flag is cleared.
> 
> Signed-off-by: Daeho Jeong <daeho.jeong@samsung.com>
> Signed-off-by: Youngjin Gil <youngjin.gil@samsung.com>
> Tested-by: Hobin Woo <hobin.woo@samsung.com>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
