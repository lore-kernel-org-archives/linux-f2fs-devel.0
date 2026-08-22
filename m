Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB8A1C5DF8C
	for <linux-f2fs-devel@archiver.kernel.org>; Sat, 22 Aug 2026 07:38:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Content-Transfer-Encoding:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=cJmjuWlfk/xhUWtQUEfqAdEA+wKU5ysmFNdkKgdJQ7k=; b=EXvlysPMTqR24MvLwWAhSpCuqL
	N9XLnOfG/KslLyX5TsjiYDFdJ3dTIxMnHdn/1/AC5FAK92UClr5UUw2IWZ0I9LNsVSG4Oj5SOAg38
	qwDwbOXSMiVgZmtuuUYbFLNatTItsbOgmPVNRHJ/a5IYtGUIVm8k47xEFZg7v2fyNcVk=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wxgJ1-0005Ql-I5;
	Sat, 22 Aug 2026 07:38:20 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1wxgIh-0005QM-0v
 for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 22 Aug 2026 07:37:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=8CvHjvXP+kHtQ8tIr0MlB+0flRSBAUTG8e7ZjQUQQMM=; b=Ce0xqgO2TSm5xH2JawLYOv+l4+
 zaMPeid+CA0K1zgGShXPFU7eyjUJADX1V7gRTmGAM2yGTStkNEaAfGihjg0Rjs9CiwpECdQUVP/Bc
 ZVElcux/ixGztwNw76MPsgwe8k5z/rW2JBjJbgeIZnOUtji4dMQRxaeZ1N/5xheDGeI0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=8CvHjvXP+kHtQ8tIr0MlB+0flRSBAUTG8e7ZjQUQQMM=; b=nUHgRaf/pp7Jq/A7oxJlvBHe+2
 zac1d5mar/NYvabH1o+EbNvi3HScF+OSJRuCExf2kdK8+cFrRZyMz1pkfHkHOi04bBW6JPGbTfX/1
 +AJct4a6FW4SYuYwI0TAfa5af1XRihV0n2TSQBvIl5QljbYfKSsDYHqQikEmBzpXEIDM=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wxgIh-0001Nm-AS for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 22 Aug 2026 07:37:59 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id AF161600E2
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Sat, 22 Aug 2026 07:37:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74BC31F000E9;
 Sat, 22 Aug 2026 07:37:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787384273;
 bh=8CvHjvXP+kHtQ8tIr0MlB+0flRSBAUTG8e7ZjQUQQMM=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To;
 b=O/AmjEByJiSI4jiAT8YbHWCSy26jGBVWGxADc2dh24ojEJcobqe+SUGYzQV1tysmk
 gKsJIBQ1skUC3JYCcNdFxgm6letIQ5xWENnYoZ2ntjbBZCx/r+ias+IbKRkI0VYuaJ
 EXPw2Wn6PW4TWrHuYT0xnghJ4e8T/6GkQMeZwFcnKLn9JKznQpFChURcavRxmGGR4I
 ZHQs8PJeOyTY+5p7EeXypHHQCzJ+JN8J0SONooieouIf+SZO4edgXs03G6U4Zjtv/t
 E7rIihowPGiPX+J7oJBjk8G/9SH0zqYwrBeHvLCPy0cEj/5jT7+b9JLcrTyO7nO9ix
 to3ndndt5Jcgg==
Message-ID: <a651e394-7c07-409b-898d-102a1fc9926b@kernel.org>
Date: Sat, 22 Aug 2026 15:37:50 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
References: <20260818200121.2684318-1-jaegeuk@kernel.org>
 <aohtWfHNbUwxoQg2@google.com>
Content-Language: en-US
In-Reply-To: <aohtWfHNbUwxoQg2@google.com>
X-Headers-End: 1wxgIh-0001Nm-AS
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: don't leave the hashed inode while
 it's unlinked
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 8/21/26 23:23, Jaegeuk Kim via Linux-f2fs-devel wrote:
> f2fs_symlink()
> 1. f2fs_new_inode
> 2. f2fs_add_link
> 3. write_being|end to fill the symlink path
> 4. flush dirty pages and or checkpoint
> 
> Step 4 is nice to succeed, which doesn't become a reason to roll back
> the created symlink. OTOH, if we get an error till step 3, don't leave
> its dentry and its inode.
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
