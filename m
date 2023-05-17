Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FA0AC77B75
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 17 May 2023 01:58:15 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1pz6Qf-0007wd-90;
	Wed, 17 May 2023 01:58:13 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1pz6Qe-0007wX-AN
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 17 May 2023 01:58:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=IIvmiCC7HES+B+4pqZIaef/0QqyQyhXTr1FtnSOc1Fs=; b=DcSLhDa9ME2WQgyNMvIIozxf12
 39ywmRFDMLyomuNOoEAdNWKcXjxjFMjodNYJ1P5X5ZZjpQUUdUx6YA5LfD6WnMzzcj/Z8Fx46d9YU
 5A9+SMx88gq4csWmhkhx44nSh6rS93Wuatw/jLQZnt+nEuHqFH6B78z+denw1wWwtoak=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=IIvmiCC7HES+B+4pqZIaef/0QqyQyhXTr1FtnSOc1Fs=; b=IYc0ZysYQNIQ/1t6Ef/rHwZhfw
 iPgrh61XCn65eSxU2r4srBQ0w9/exf6+xLCoYtyW+4q8df93T938u70PaXRvWhbxORaMm1K6djXlR
 8A6qXvJr8WYCe0tIKn+LS++0eyNTdDQLlbNWTQ9gPKB7eGJ4f+n33FYotaXcWGHtXYMM=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1pz6Qe-0008LJ-2b for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 17 May 2023 01:58:12 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id AEF946409B;
 Wed, 17 May 2023 01:58:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15C58C433EF;
 Wed, 17 May 2023 01:58:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1684288686;
 bh=iZPh21wWGEBlWp0JhELY/nnSc0qMTktgaIMhNOa939Y=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=lccZN5Z72cMdKzTCsD8HEpTEg348OV+fYQvFpY+yBaJW9dd0IRieqEZXcaK5E9hV4
 NNzHD2l+2ZuMwY1ibFhGmgv07BeKp+LSZrGZmcGIiUt/kaGa0mdjYMWv/syN8MWvXI
 ioYoGte6fx/AJhwCFQeJfH/PketNR2dOxJdG/wcWZhJj3cMjP1lgZIN/BcvH+GSm3i
 N9sGY8fyiJFB5kW7IknjlGsVJMDe4PqKJmEGZFbbyp9P1V+YSS1DvM2aZZXJ+uMwNv
 BLiLEi6UsikOXuPwCjL8r6lBX+PEt+E5Uhjuxt03FWkZCpRSj0FPKHM7yvgXFe4oad
 508O7ZlYAhhgw==
Message-ID: <2c8e3028-ea3c-d751-1ee6-74b1aca14992@kernel.org>
Date: Wed, 17 May 2023 09:58:04 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Content-Language: en-US
To: Yangtao Li <frank.li@vivo.com>, jaegeuk@kernel.org
References: <20230506144257.9611-1-frank.li@vivo.com>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20230506144257.9611-1-frank.li@vivo.com>
X-Headers-End: 1pz6Qe-0008LJ-2b
Subject: Re: [f2fs-dev] [PATCH v2 1/2] f2fs: move the conditional statement
 after holding the inode lock in f2fs_move_file_range()
X-BeenThere: linux-f2fs-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2023/5/6 22:42, Yangtao Li wrote:
> For judging the inode flag state, the inode lock must be held.
> BTW, add compressd file check and to avoid 'if' nesting.

Please describe what's the detail problem if we check the flag w/o inode
lock.

Can we use one single patch to fix all similar issues?

Thanks,

> 
> Cc: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> Fixes: 4dd6f977fc77 ("f2fs: support an ioctl to move a range of data blocks")
> Signed-off-by: Yangtao Li <frank.li@vivo.com>
> ---
> v2:
> -add unlock
>   fs/f2fs/file.c | 18 ++++++++++++------
>   1 file changed, 12 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> index 78aa8cff4b41..42a9b683118c 100644
> --- a/fs/f2fs/file.c
> +++ b/fs/f2fs/file.c
> @@ -2790,9 +2790,6 @@ static int f2fs_move_file_range(struct file *file_in, loff_t pos_in,
>   	if (!S_ISREG(src->i_mode) || !S_ISREG(dst->i_mode))
>   		return -EINVAL;
>   
> -	if (IS_ENCRYPTED(src) || IS_ENCRYPTED(dst))
> -		return -EOPNOTSUPP;
> -
>   	if (pos_out < 0 || pos_in < 0)
>   		return -EINVAL;
>   
> @@ -2804,10 +2801,19 @@ static int f2fs_move_file_range(struct file *file_in, loff_t pos_in,
>   	}
>   
>   	inode_lock(src);
> -	if (src != dst) {
> +	if (src != dst && !inode_trylock(dst)) {
>   		ret = -EBUSY;
> -		if (!inode_trylock(dst))
> -			goto out;
> +		goto out;
> +	}
> +
> +	if (IS_ENCRYPTED(src) || IS_ENCRYPTED(dst)) {
> +		ret = -EOPNOTSUPP;
> +		goto out_unlock;
> +	}
> +
> +	if (f2fs_compressed_file(src) || f2fs_compressed_file(dst)) {
> +		ret = -EOPNOTSUPP;
> +		goto out_unlock;
>   	}
>   
>   	ret = -EINVAL;


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
