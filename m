Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7D6BCCF9E0
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 28 Oct 2025 01:56:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pX8SAI97JCHuZ33yNPL0cnskcqD1yRMxc5iAbJomong=; b=f2C8J3Uf8VZ7NH2f9hVmC5VMfB
	UiliXwkeqU0wlOKm3Gvsvw/iypV5zLnRMYSpJ7xjAAN0uQL8u+EyrOJh30LpeHJOHZV4mZL9z1iBZ
	m9r7Hc566Vmyg+1oy5fdaXxwp0ULLgzSk6BkQ87HM5Z3Hq/QoH9yy7PahgzTYB6tL+r4=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1vDYwn-0008Lw-Ul;
	Tue, 28 Oct 2025 01:56:29 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1vDYwm-0008Lp-By
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 28 Oct 2025 01:56:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=pKhvN679zIOn4aZ8axMJcfcgYtDgbMdFi/IbMlRYHRw=; b=NjnGfpy3AwDwOokfyVc3IRpv4z
 iM5qp9X5Wecuee7h4ym5yl2dfLnIoJ+wgGNcpX5EPsZNrkt/9IA79UbmY1UKJxQo0eKslVxnren5K
 GuB+Crc+z2x4v0RBcmGGAf0fDNYjg9JKZ1G4jpVl21kPZ/RhvMgQ/mXoxZ2biGtbOg24=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=pKhvN679zIOn4aZ8axMJcfcgYtDgbMdFi/IbMlRYHRw=; b=NpFhCR2ao+jPSC3Dd3LxQr+yTO
 fXO9HQjYBk3H1ze5vUXD9DA3qFJ4mSvTPu97nH6Ah/HQK0I2WubD1nxSPB3XMOhsUqK9LndB14vip
 6AUMNkyFGnwrbkE15R8tuxdWMSPgqztrW4eL9XfxUnAIsYdYNTtDwlbx4U4Q7bxqZyiU=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1vDYwl-0007Tc-UP for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 28 Oct 2025 01:56:28 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 8BCEE45EFA;
 Tue, 28 Oct 2025 01:56:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F81AC4CEF1;
 Tue, 28 Oct 2025 01:56:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1761616577;
 bh=jzowAsoYoY9hJtrOeZBq34uXlkyAo9xXj+0K78RjkJI=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
 b=t7+SVI8Z4ntQoi+Di9X5rMtYvlHeO9U7OA0Tre3Hm/14qSfZ6Q+nh4mRP+boPf7Tp
 2566vZJmRm9y3ezW/12RMY98YGzB/25VeWhRUxmsS/cabZesh3SnqHBWtMDxwvgjEI
 W6mvmK+/6it6wUd95TlkK+3c2acdHKEh6FYUa6Vt6ovRzp0+vlRXYeTX+voeOo6XNA
 jBJxa9gHVPcrlVE2y+RyfIIetdYjwJDOj/mk9CvuCzGXb7uThtTCns72T9xAVzpwil
 gX1R+whWrhjhIvjpI76VBEgoNafbnDbPXQZ5S+VZWFltJE9PpXdfv8kJfoxSmnPoQc
 GPAXKt50Yy2NA==
Message-ID: <689c9daf-5602-4f3f-9811-37969ca66b05@kernel.org>
Date: Tue, 28 Oct 2025 09:56:14 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Yongpeng Yang <yangyongpeng.storage@gmail.com>,
 Jaegeuk Kim <jaegeuk@kernel.org>
References: <20251027125543.633506-1-yangyongpeng.storage@gmail.com>
Content-Language: en-US
In-Reply-To: <20251027125543.633506-1-yangyongpeng.storage@gmail.com>
X-Headers-End: 1vDYwl-0007Tc-UP
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: change the unlock parameter of
 f2fs_put_page to bool
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
Cc: Yongpeng Yang <yangyongpeng@xiaomi.com>,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 10/27/25 20:55, Yongpeng Yang wrote:
> From: Yongpeng Yang <yangyongpeng@xiaomi.com>
> 
> Change the type of the unlock parameter of f2fs_put_page to bool.
> All callers should consistently pass true or false. No logical change.
> 
> Signed-off-by: Yongpeng Yang <yangyongpeng@xiaomi.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
