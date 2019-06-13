From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH] f2fs: separate f2fs i_flags from fs_flags
 and ext4 i_flags
Date: Thu, 13 Jun 2019 14:20:41 +0800
Message-ID: <ac9370d1-82a2-bb8a-4d9d-fe2e763df789@huawei.com>
References: <20190605055904.4039-1-ebiggers@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <yuchao0@huawei.com>) id 1hbJ6Y-0000FP-1D
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 13 Jun 2019 06:20:58 +0000
Received: from szxga06-in.huawei.com ([45.249.212.32] helo=huawei.com)
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1hbJ6U-00B9y1-I0
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 13 Jun 2019 06:20:56 +0000
In-Reply-To: <20190605055904.4039-1-ebiggers@kernel.org>
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
To: Eric Biggers <ebiggers@kernel.org>, linux-f2fs-devel@lists.sourceforge.net
Cc: linux-fsdevel@vger.kernel.org

On 2019/6/5 13:59, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> f2fs copied all the on-disk i_flags from ext4, and along with it the
> assumption that the on-disk i_flags are the same as the bits used by
> FS_IOC_GETFLAGS and FS_IOC_SETFLAGS.  This is problematic because
> reserving an on-disk inode flag in either filesystem's i_flags or in
> these ioctls effectively reserves it in all the other places too.  In
> fact, most of the "f2fs i_flags" are not used by f2fs at all.
> 
> Fix this by separating f2fs's i_flags from the ioctl bits and ext4's
> i_flags.
> 
> In the process, un-reserve all "f2fs i_flags" that aren't actually
> supported by f2fs.  This included various flags that were not settable
> at all, as well as various flags that were settable by FS_IOC_SETFLAGS
> but didn't actually do anything.
> 
> There's a slight chance we'll need to add some flag(s) back to
> FS_IOC_SETFLAGS in order to avoid breaking users who expect f2fs to
> accept some random flag(s).  But hopefully such users don't exist.
> 
> Signed-off-by: Eric Biggers <ebiggers@google.com>

Looks good to me, thanks for cleaning all mess up. :)

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,
