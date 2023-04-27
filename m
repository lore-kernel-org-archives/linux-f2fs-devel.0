Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5664FC77B61
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 27 Apr 2023 09:38:33 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1pry59-00057I-1e;
	Thu, 27 Apr 2023 09:38:30 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1pry58-00057C-4x
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 27 Apr 2023 09:38:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=varyPhf3NEmOILi0YtI+maJKdssUKYyCq/A5XgGZskU=; b=ZA9Y2aOpbUF3W/irFVmkyo8+Tw
 b2PYUBZBWquH+kaJcJRZLqNzfV6lMOQaOj5M89IAsBVwNlApHQeOFNeL+lBoEra+NXwZ4tQe6pZB/
 qIaoi678NuEBKE+DogKJErbEUL/hoBimmSoTSAEb+DoaB0+h75F3J37rFjeAbJ9ikGPA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=varyPhf3NEmOILi0YtI+maJKdssUKYyCq/A5XgGZskU=; b=XhwINBQ06nSK5A/0lFnqZ43oj0
 4pIN0M3cfJxcqRFXILPXCPNOjDRKqSe7Z3tqXT+7g8VBF1xqefvEyOhxNlkZ57hypFFXecRI7lnN0
 H04up8qvawsKJO0oRoMytmfcYDxDuEseuKqANpUe+n9uPzh06ol5W46EuwPw6H4zCRog=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1pry56-0003Ys-NH for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 27 Apr 2023 09:38:29 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 558156396F;
 Thu, 27 Apr 2023 09:38:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D922C433EF;
 Thu, 27 Apr 2023 09:38:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1682588302;
 bh=8h3n++F1xXGmMbuOXjl1rR2J8pNfIheLahD5RfGRUfk=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=EjKKegG6uccwvlOD9bx9j7Xn+WMIH5PPxpdO+uu48UeQLht6Kr97s95yJc74N1bcA
 89kwt5mMhNjrBBysK467aa4QKFaIZW7wcSEDHK9V6ookjxXB5akAsu4ACKKeTABTg0
 eqRC/vCgq81nCVej2DZeUer0J4lnFcUlhKZ/hY3THvKws4w1dVz36z7LuYu4hY8zLy
 4TnG74khF3+ANXT0q/VYEbfFEZ1NZruqjQKFvbqUSbdUep/LhTlqtPyxrqaE/yg0r6
 meeoQCi1d2clRoz/lYF3DTTfG+aPVEuTlHr2Yl0RSLxD5d8mDGyNVBfE9tQ6BXxPz4
 BwxbGb0EtHhBA==
Message-ID: <626404fe-3547-979f-f483-b43416f6f88a@kernel.org>
Date: Thu, 27 Apr 2023 17:38:19 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Content-Language: en-US
To: Yangtao Li <frank.li@vivo.com>, Jaegeuk Kim <jaegeuk@kernel.org>,
 Daeho Jeong <daehojeong@google.com>
References: <20230425151126.50566-1-frank.li@vivo.com>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20230425151126.50566-1-frank.li@vivo.com>
X-Headers-End: 1pry56-0003Ys-NH
Subject: Re: [f2fs-dev] [PATCH] f2fs: do not allow to defragment files have
 FI_COMPRESS_RELEASED
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
Cc: Qi Han <hanqi@vivo.com>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2023/4/25 23:11, Yangtao Li wrote:
> If a file has FI_COMPRESS_RELEASED, all writes for it should not be
> allowed.
> 
> Fixes: 5fdb322ff2c2 ("f2fs: add F2FS_IOC_DECOMPRESS_FILE and F2FS_IOC_COMPRESS_FILE")
> Signed-off-by: Qi Han <hanqi@vivo.com>
> Signed-off-by: Yangtao Li <frank.li@vivo.com>
> ---
>   fs/f2fs/file.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> index 9c9c3f660e01..c21d6a829c4a 100644
> --- a/fs/f2fs/file.c
> +++ b/fs/f2fs/file.c
> @@ -2734,6 +2734,9 @@ static int f2fs_ioc_defragment(struct file *filp, unsigned long arg)
>   	if (f2fs_readonly(sbi->sb))
>   		return -EROFS;
>   
> +	if (is_inode_flag_set(inode, FI_COMPRESS_RELEASED))
> +		return -EINVAL;

This flag should be checked w/ inode lock.

Thanks,

> +
>   	if (copy_from_user(&range, (struct f2fs_defragment __user *)arg,
>   							sizeof(range)))
>   		return -EFAULT;


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
