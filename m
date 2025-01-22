Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B3D4C02181
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 22 Jan 2025 06:27:28 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1taUD0-0004QG-RT;
	Wed, 22 Jan 2025 06:27:26 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1taUCz-0004Q8-M7
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 22 Jan 2025 06:27:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=9m8ro0Y6UzTpslGzUqmQs7PXNpKVW7HV3e212HVruM0=; b=Q9O8uPnr2iDbCPPgc7NIzITyCd
 LR4nUX9GOY5cl75GLohiKXXdrVvpDKomgluZSIng6pMtyuL8HrkAtaId03Ey1xRETAg5lvWjAexXd
 XR7Qi8s00IVgq4vZEpOMM5gM5JsgszfsUpsBeNhQ/Twa4zN/HkjbOmABYg5Paoia4VJ4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=9m8ro0Y6UzTpslGzUqmQs7PXNpKVW7HV3e212HVruM0=; b=dLBfEE/HVs70yERiRoI9cQDIOp
 YjkfcX7hFCCwRMYgXbsXb+xAqaybu4agZuuFH1Uzu3jmWE86NCNkkvs536occ70uBFDT9MHMmWHMV
 vqqZ++i0wX8IcRE4ob4kJzROctTChLWxFBn422gWFXV4qTVXkO7pyOkqs0B3oL9eH+y0=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1taUCy-000859-EW for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 22 Jan 2025 06:27:25 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id AAAB35C576A
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed, 22 Jan 2025 06:26:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B92E8C4CED6;
 Wed, 22 Jan 2025 06:27:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1737527238;
 bh=3uyDNXZMF6q74hmz/0okmpumOJCrDAdJLd7qiVTTyr4=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
 b=iU0gmul2B6dXARK1xobfHCBWcboxirQwrFdoNCs50x/Woyc+8oJ64DOKEuTPS+biF
 SQiqJsbOrbjsKS6CWpnnZo4+kfsiP7lkMFSgKw8iXGf1Auno0LXnnrzCt2hFsybq/u
 xtiFr+VDpguqSIryO3dnDtJ40bT/yGRqdqZKPC0EQBRc7+zscqanSQpWCECS6KDP4R
 TpHWTliKeuanZbY7TqgvDaL33gGIm4Qut90ppRqSmIbWNgtCsWi35+hkw+s5XfIGVx
 23R7xUOAtt6Q9xwXi+iChMUfoJ8omIs4N/LiahmcDYullalaGTKAIU+6O361VuGli3
 9gARzjEtH8e0A==
Message-ID: <bef8db0a-f2ef-4aea-ab19-c3390f7bf93e@kernel.org>
Date: Wed, 22 Jan 2025 14:27:14 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Nathan Chancellor <nathan@kernel.org>, Jaegeuk Kim <jaegeuk@kernel.org>
References: <20250120-f2fs-fix-wformat-min_inline_xattr_size-v1-1-508cac1474fe@kernel.org>
Content-Language: en-US
In-Reply-To: <20250120-f2fs-fix-wformat-min_inline_xattr_size-v1-1-508cac1474fe@kernel.org>
X-Headers-End: 1taUCy-000859-EW
Subject: Re: [f2fs-dev] [PATCH] f2fs: Fix format specifier in
 sanity_check_inode()
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
From: Chao Yu via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Chao Yu <chao@kernel.org>
Cc: patches@lists.linux.dev, linux-f2fs-devel@lists.sourceforge.net
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 1/20/25 20:59, Nathan Chancellor wrote:
> When building for 32-bit platforms, for which 'size_t' is 'unsigned int',
> there is a warning due to an incorrect format specifier:
> 
>    fs/f2fs/inode.c:320:6: error: format specifies type 'unsigned long' but the argument has type 'unsigned int' [-Werror,-Wformat]
>      318 |                 f2fs_warn(sbi, "%s: inode (ino=%lx) has corrupted i_inline_xattr_size: %d, min: %lu, max: %lu",
>          |                                                                                                 ~~~
>          |                                                                                                 %u
>      319 |                           __func__, inode->i_ino, fi->i_inline_xattr_size,
>      320 |                           MIN_INLINE_XATTR_SIZE, MAX_INLINE_XATTR_SIZE);
>          |                           ^~~~~~~~~~~~~~~~~~~~~
>    fs/f2fs/f2fs.h:1855:46: note: expanded from macro 'f2fs_warn'
>     1855 |         f2fs_printk(sbi, false, KERN_WARNING fmt, ##__VA_ARGS__)
>          |                                              ~~~    ^~~~~~~~~~~
>    fs/f2fs/xattr.h:86:31: note: expanded from macro 'MIN_INLINE_XATTR_SIZE'
>       86 | #define MIN_INLINE_XATTR_SIZE (sizeof(struct f2fs_xattr_header) / sizeof(__le32))
>          |                               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> Use the format specifier for 'size_t', '%zu', to resolve the warning.
> 
> Fixes: 5c1768b67250 ("f2fs: fix to do sanity check correctly on i_inline_xattr_size")
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
