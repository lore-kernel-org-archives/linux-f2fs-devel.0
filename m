From: Chao Yu <chao@kernel.org>
Subject: Re: [PATCH v2 2/2] f2fs: fix setattr project check upon
 fssetxattr ioctl
Date: Mon, 10 Sep 2018 22:45:38 +0800
Message-ID: <acdda52b-02a2-52e9-4e96-2fa67ddc29a7@kernel.org>
References: <1536484514-16202-1-git-send-email-wshilong1991@gmail.com>
 <1536484514-16202-2-git-send-email-wshilong1991@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <chao@kernel.org>) id 1fzNRn-0003S1-0S
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 10 Sep 2018 14:45:51 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1fzNRk-00Fluj-Lg
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 10 Sep 2018 14:45:50 +0000
In-Reply-To: <1536484514-16202-2-git-send-email-wshilong1991@gmail.com>
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
To: Wang Shilong <wangshilong1991@gmail.com>, linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: adilger@dilger.ca, wshilong@ddn.com, dchinner@redhat.com

On 2018/9/9 17:15, Wang Shilong wrote:
> From: Wang Shilong <wangshilong1991@gmail.com>
> 
> Currently, project quota could be changed by fssetxattr
> ioctl, and existed permission check inode_owner_or_capable()
> is obviously not enough, just think that common users could
> change project id of file, that could make users to
> break project quota easily.
> 
> This patch try to follow same regular of xfs project
> quota:
> 
> "Project Quota ID state is only allowed to change from
> within the init namespace. Enforce that restriction only
> if we are trying to change the quota ID state.
> Everything else is allowed in user namespaces."
> 
> Besides that, check and set project id'state should
> be an atomic operation, protect whole operation with
> inode lock.
> 
> Signed-off-by: Wang Shilong <wshilong@ddn.com>

It looks good to me, thanks for the patch, Shilong. :)

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,
