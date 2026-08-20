Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C11C1C5DF87
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 20 Aug 2026 23:52:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Content-Transfer-Encoding:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=PLKxJV2lY5s3VeiFtwMxBcn4+1dRy9MC7VGQsohm4Rs=; b=YojxIOP0XFF+0yWf/7AUIKFsVe
	u7b/Tn56AdAiGkz/7T/UImts/BJ1gLH5MtenGIgSoofflNpNAWW03osN94g1pl0yJv67FMUiKvrY5
	QJ78SBpfKRx+4Qy3nycHAMat0+w+cmMQsnxRxCXOLkBT1710qMAdh+NWSRoepJ/Mjdb4=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wxCYT-0002dl-Nm;
	Thu, 20 Aug 2026 23:52:18 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1wxCYR-0002dc-MZ
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 20 Aug 2026 23:52:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=NbZgEP2jtLb0zDRuTTx1wqr8n4blUjQ30H0Se2VZ7V4=; b=AZ2G/Y3haDQdGMgvpdFZXupN4A
 /8Se7JvmSD7xPE2NmlGHpebkYi6OAY5aqbgXgbcxdNVXNsIXUL/QuSZzVC67FaZrGpjo0F1VaXCrx
 JsMay5lceFishiXtKk1aE2JEGQEwJWGESy2InOmPMe5UnSJKYLG2WGwUr1ZF/RTwzWFo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=NbZgEP2jtLb0zDRuTTx1wqr8n4blUjQ30H0Se2VZ7V4=; b=F15RbIB4IYIz/r5IEZrTxKA0V9
 j7T4s5uJW1j1OD7NnCT4jt9V7wMJldiUzaCWs0wQVqxPa0HBH2IRXFzCECNgRaaREw9q0Rf5cR7re
 qXtc4JbX4C3swzYdOcaLgAktQafkT33LgU7gP2VebVVWDV9TAn/CaApM8OrKOUJFlL/U=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wxCYS-0006Hu-1c for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 20 Aug 2026 23:52:16 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 63EE360A58;
 Thu, 20 Aug 2026 23:52:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 208BB1F000E9;
 Thu, 20 Aug 2026 23:52:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787269930;
 bh=NbZgEP2jtLb0zDRuTTx1wqr8n4blUjQ30H0Se2VZ7V4=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To;
 b=AGdoBk4ZwdPFVCtF/6TcPSezuzLn+j0b9px0owJeFroU51m2gDBPPqLZijBLnFMxs
 s01KfNYgBe2a3mZfGtHQtLpGH7bbYsL4TnpQhwfHm7CHWT15yFEXpU2o4vE119ULG8
 itd1zbRdq9NPqnjmtKVABdzitjb8FPiembn3FYalXJxoydEGEAfGBzORlQVSm9C+Ev
 iTITsXzTYsRtcmHooZ3eepB47+9LiMplnKLUk74TiZi5x7niFexDKB/pkrHPYPn4Vz
 O/lwcLZ/L7j1AhK48Lb5oWk0SIhsCaM7slBCAghvyeNDZPudoWYkXa0qCYZT+bMb41
 LVdrSp4cePmnA==
Message-ID: <55fed9d7-cec1-42f8-9b79-19a95bacb340@kernel.org>
Date: Fri, 21 Aug 2026 07:52:06 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Daeho Jeong <daeho43@gmail.com>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
References: <20260820164340.2802152-1-daeho43@gmail.com>
Content-Language: en-US
In-Reply-To: <20260820164340.2802152-1-daeho43@gmail.com>
X-Headers-End: 1wxCYS-0006Hu-1c
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: avoid setting SBI_NEED_FSCK on
 transient resize failure
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
Cc: Daeho Jeong <daehojeong@google.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 8/21/26 00:43, Daeho Jeong wrote:
> From: Daeho Jeong <daehojeong@google.com>
> 
> When free_segment_range() fails in f2fs_resize_fs(), no on-disk
> superblock or filesystem metadata has been modified yet, and
> free_segment_range() safely restores all in-memory counters before
> returning.
> 
> However, the current error recovery path unconditionally sets the
> SBI_NEED_FSCK flag and prints a scary error message on any error,
> forcing an unnecessary and time-consuming fsck.f2fs repair on the
> subsequent mount/reboot.
> 
> Fix this by separating the error recovery path with a dedicated
> recover_user_blocks label to bypass setting SBI_NEED_FSCK on
> free_segment_range() failures.
> 
> Signed-off-by: Daeho Jeong <daehojeong@google.com>
> Signed-off-by: Sunmin Jeong <s_min.jeong@samsung.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
