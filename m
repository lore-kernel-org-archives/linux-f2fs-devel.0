Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BF7BCD8CB9
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 10 Jun 2026 11:05:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=b54+e/7sc0dt6Jm7CILD+5e8tNj9iuBdOATVYTY9mdo=; b=gdr7LlhkKiOU+xv6V+HW4p+rJ4
	tEt87uC27fWDs9z+6ed7Al9qWRGdZpLpPWAr7i3Fu5UDyhSMY6/4xeBk0r24dy529eRrcPaNs+53y
	IHPUa/aWC6FCdb4nHHt4qIex/Fo0DQou985bjCHAhtMA5kNXx4ESJhdN0717/udq7MFU=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wXGk4-0008JJ-7d;
	Wed, 10 Jun 2026 11:05:05 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1wXGk2-0008J6-FY
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 10 Jun 2026 11:05:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=gec56jDNCc+maVNdZuXtaR5ojRmZaneAPy5zAV3Mynw=; b=CXVifX4RvMGBzipemH0iL98y//
 rPw5aebMiW28bCB849nC48BIpCAZOz7hXbqqQL7h6I+thSZW858fHjWhfb5HZ4lsiRth8A9DaX6wi
 t7H4MYlzwjPPf6P7mojZCm5vpMVWkvGy/Zg5yfvxIL7wg7QFO5fsPPpX3nwwCnPFsaDo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=gec56jDNCc+maVNdZuXtaR5ojRmZaneAPy5zAV3Mynw=; b=N1KmaTHt82jq3ikd8ug+r0AZtK
 37eBYemOOR8ApqWN9uP+8HdHeF1O7uTdLMiPmZ3yE8Eoql/fdfY51QL04BOBLkEOHGi8WDayvzv6e
 w6bur9sZeKMS7lA9CPXMmr1mAy/MQR684uXeidgS8pUPTMpg61LQBAAQclbMZ1IAiaAM=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wXGk0-0004fS-0U for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 10 Jun 2026 11:05:03 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id DA1DC60540;
 Wed, 10 Jun 2026 11:04:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 779251F00893;
 Wed, 10 Jun 2026 11:04:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781089494;
 bh=gec56jDNCc+maVNdZuXtaR5ojRmZaneAPy5zAV3Mynw=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To;
 b=cgxNzYw6BhlPNzoabP6kB9x2I0d9J8cJKpBV7QIlt7iWYyoecBbS/MZb6Pcwvfbag
 N0aD0rmUNew5/pm6wrW955oYLFckfOeHTuxMnRGdLrBIExI2MjqrSw1eL4JZRxjD5i
 9Ab/Eb1U32ZMvtFWSxNVLfLJw8ivqYhEdycMhuk1gGv0hD3L+KJOgWzIHld5E/Zc0l
 Qpgf6MdOrmOWbdLgG/mFr+EAr57Mj5ImTs9G+X1LoBJD9IB+X3TkVvYACMofj8mH/o
 rrCtGMaZrZcOj1PkTms8eszfzwqj/y27zj8Oo64BqPPBQgEw5V/rErwlhKI2qXWrNH
 jiTPAPX8jbV+w==
Message-ID: <338266b5-9353-4884-9ca4-21eed1177cde@kernel.org>
Date: Wed, 10 Jun 2026 19:04:51 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Wenjie Qi <qwjhust@gmail.com>, jaegeuk@kernel.org
References: <20260526113505.1312431-1-qiwenjie@xiaomi.com>
Content-Language: en-US
In-Reply-To: <20260526113505.1312431-1-qiwenjie@xiaomi.com>
X-Headers-End: 1wXGk0-0004fS-0U
Subject: Re: [f2fs-dev] [PATCH f2fs-tools] fsck.f2fs: recognize inconsistent
 orphan error
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
Cc: qiwenjie@xiaomi.com, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 5/26/26 19:35, Wenjie Qi wrote:
> The kernel can record ERROR_INCONSISTENT_ORPHAN in the superblock
> s_errors[] field when orphan inode metadata is inconsistent.
> 
> Add the matching f2fs_error entry and fsck error string so fsck.f2fs
> can recognize and print this persistent corruption hint.
> 
> Signed-off-by: Wenjie Qi <qiwenjie@xiaomi.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
