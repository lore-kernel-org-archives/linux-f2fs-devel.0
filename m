From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH] f2fs: call unlock_new_inode() before
 d_instantiate()
Date: Mon, 23 Apr 2018 11:25:47 +0800
Message-ID: <d3a0a778-3511-b34b-66d4-30ba02b64eaf@huawei.com>
References: <20180418224842.195203-1-ebiggers3@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <yuchao0@huawei.com>) id 1fAS71-0006gJ-TH
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 23 Apr 2018 03:25:55 +0000
Received: from [45.249.212.32] (helo=huawei.com)
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1fAS70-0088a7-3e
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 23 Apr 2018 03:25:55 +0000
In-Reply-To: <20180418224842.195203-1-ebiggers3@gmail.com>
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
To: Eric Biggers <ebiggers3@gmail.com>, linux-f2fs-devel@lists.sourceforge.net, Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Eric Biggers <ebiggers@google.com>

On 2018/4/19 6:48, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> xfstest generic/429 sometimes hangs on f2fs, caused by a thread being
> unable to take a directory's i_rwsem for write in vfs_rmdir().  In the
> test, one thread repeatedly creates and removes a directory, and other
> threads repeatedly look up a file in the directory.  The bug is that
> f2fs_mkdir() calls d_instantiate() before unlock_new_inode(), resulting
> in the directory inode being exposed to lookups before it has been fully
> initialized.  And with CONFIG_DEBUG_LOCK_ALLOC, unlock_new_inode()
> reinitializes ->i_rwsem, corrupting its state when it is already held.
> 
> Fix it by calling unlock_new_inode() before d_instantiate().  This
> matches what other filesystems do.
> 
> Fixes: 57397d86c62d ("f2fs: add inode operations for special inodes")
> Signed-off-by: Eric Biggers <ebiggers@google.com>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
