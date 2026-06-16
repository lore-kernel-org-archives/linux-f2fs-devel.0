Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75CEACD98DE
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 16 Jun 2026 03:16:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MAxiWOkwAhRdBbcpzLKLshujln0AzlNRscLhzyE1qDY=; b=MvC0JEy4pr4uN1lltPAuubgDt0
	Q3nJNmzoFQsEIQnHZaNLyPj/pwKywwIt1WkXcE/pjddo7AUzT/2i+iq0TkkUFYz3LcxCJoiQCWGmi
	HOiil1DdPMNQYp7IP5k7nEBILZ/sjUdKsaa6gNX23iIALhwJD+40z4SuBSsJFmzZyZsg=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wZKHj-0004kn-Jw;
	Tue, 16 Jun 2026 03:16:20 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1wZKHj-0004kf-1M
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 16 Jun 2026 03:16:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=7qcGy97RJthIKYNTKcmD6a7zj/H4lLk55pYE5C8ndeU=; b=bv3fUE1b6fHXYhjK6I/NCTqYo1
 ewp963S24vu+ER2Ja3vZp5zHQz/2m2gdd6fHPDbXZ9GEjzET1GFzPUtOFaC25IFhk1Ww0fhQ+xiFV
 +7Vm4q6m3ln/6B+tYdZWd77v8N8e6iyubmbYchw3BmwsYqFFb/DzW5sCmRUfgco157O0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=7qcGy97RJthIKYNTKcmD6a7zj/H4lLk55pYE5C8ndeU=; b=B+R/CzmgbW6iTB3eeXf3i6w/ud
 8Syishv3Fm4ky4dZ/GsQLjPuNyEmgLYdtYQf89madfp3Ngr7fOpSrEe9+UC07uMeibzugvaFwZdJc
 VHRBuYrGkFDq+3vpJYJ7MyM4BmlQS5ema8qjZ4UL+PHPElu6ZhV3JJ3gdZ8NRoJTO1iE=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wZKHh-0003XM-MS for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 16 Jun 2026 03:16:19 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id CE70F417D7;
 Tue, 16 Jun 2026 03:16:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 045111F000E9;
 Tue, 16 Jun 2026 03:16:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781579767;
 bh=7qcGy97RJthIKYNTKcmD6a7zj/H4lLk55pYE5C8ndeU=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To;
 b=OKLThBm/0yGIg3ovDVMnd3wSvUHacHkZj0QZz4hAu43R3lLtYPAAM0eLjXvgXIYGt
 82cDUvTLaKj/d8eMAX800aFJ3jcITs8VP5Y9sltdiL4kHMjbGvJP/teweReW1NG3eE
 BF4puJN2tSkvip2/PSBUYuYITE+p8vGOoBl1nXvTxttrAVkc1XcxecwiAqarOgu/WN
 dhjD+5W1Gpgx7t3OyB7FJbYoV5ARbGusOY3b48kX97WzwSBGVuvEMa7srnRt0dLi7z
 MGK8sGGA8P2oJUmjjtmVk9U1LGeyETQyVtfpIhPGMvLCAd2784Oyp/0/kH0EwHAKDW
 cxE+vFYlSqa4w==
Message-ID: <d9db27f3-3328-4490-b8a7-292d76b017d2@kernel.org>
Date: Tue, 16 Jun 2026 11:16:03 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Wenjie Qi <qwjhust@gmail.com>, jaegeuk@kernel.org
References: <20260616030655.111933-1-qiwenjie@xiaomi.com>
Content-Language: en-US
In-Reply-To: <20260616030655.111933-1-qiwenjie@xiaomi.com>
X-Headers-End: 1wZKHh-0003XM-MS
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: skip direct I/O iostat context when
 disabled
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
Cc: qiwenjie@xiaomi.com, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 6/16/26 11:06, Wenjie Qi wrote:
> F2FS iostat is optional and is disabled by default.  Direct I/O still
> allocates and binds a bio_iostat_ctx, updates the submit timestamp, and
> replaces bi_end_io for every DIO bio even when sbi->iostat_enable is
> false.
> 
> The byte accounting calls do not need an extra guard because
> f2fs_update_iostat() already checks sbi->iostat_enable.  Only skip the
> DIO bio context setup when iostat is disabled.  If iostat is enabled
> through sysfs before submission, the existing context allocation and
> latency accounting path is still used.
> 
> QEMU benchmark on a 1GiB F2FS virtio-blk image, with iostat_enable=0,
> 4KiB O_DIRECT I/O over a 64MiB file, 50000 iterations per run:
> 
>                          baseline     patched
>   direct_read median    65264.50 ns  55470.95 ns
>   direct_read recheck   65553.75 ns  55470.95 ns
>   direct_write median   68054.62 ns  56309.44 ns
>   direct_write recheck  66873.51 ns  56309.44 ns
> 
> Signed-off-by: Wenjie Qi <qiwenjie@xiaomi.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
