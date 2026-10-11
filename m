Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CF9FCA9ECE
	for <linux-f2fs-devel@archiver.kernel.org>; Sun, 11 Oct 2026 16:48:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:
	Message-ID:Date:To:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=KdcpFaUrV4U3vqu+frUBRarAckqWct3CU4PxW594jSA=; b=Nnt2ky3i2PiaGpLwW88I1E3cW0
	L4dhCPmbBo701jXer5n5Molog386lgaHdlShyFFbN9Q0dtjy/pR3xYloVuF+JNRny5/iMv9CdJbwZ
	yyAOSz7HTB23xAsWWJSyuf+g6AuFtELbDvMGkt8M/+7WxzCkKZxqXn8o9E0sE0+/CklQ=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xFwjA-0001Gi-Fk;
	Sun, 11 Oct 2026 16:48:46 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <sashal@kernel.org>) id 1xFwj8-0001GZ-1t
 for linux-f2fs-devel@lists.sourceforge.net;
 Sun, 11 Oct 2026 16:48:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=rTkeJ7497Y5USbg63LcsttJV/vy9qA1WCr/fkXWBRjA=; b=SHL3P1u3JAbN38Y6aLLo5DoCzV
 6qtPGRLALOAUYqj/vHN/23Wml07xFG9i/LjihyQVFHL/UtSnmbIX/XMPxnaE5WDGnAOaY8klsbOs9
 wOijfR/YG6aKogmwu0cwoy7kObLuj4nsbhnXMj/qrZYTn0/NI/58//9Z4Lq/8ch5B0+0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=rTkeJ7497Y5USbg63LcsttJV/vy9qA1WCr/fkXWBRjA=; b=CzjuzgBb5a6AS7vjX6gAgKwgwa
 Ug8jx0dL6eTc0yX8fqpb1tl4fAVZOqf/pEpOAZw3Qc7Q2ZXmigZRvcyZfGgR9M70dd+n8jPW9A7Gd
 UmBbvkvILaqPj1NiysGp4Wg/LawTw5A9R2TTK+qxNrwtNVpIp3W0lhnbjewn9VWynYrE=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1xFwj5-0007wJ-6q for linux-f2fs-devel@lists.sourceforge.net;
 Sun, 11 Oct 2026 16:48:43 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id E403D43C89;
 Sun, 11 Oct 2026 16:48:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6EB01F0089D;
 Sun, 11 Oct 2026 16:48:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791737317;
 bh=rTkeJ7497Y5USbg63LcsttJV/vy9qA1WCr/fkXWBRjA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=aDeaL4FDE0WYGI1cuyK4WOzxGvAQiF9nhl7Q24ZrZ9uOaLQVdxNMz6bBWg7TKP7JL
 hC80H+iNpUvNT+Ae8jPeYBNWMq8dLJma97dGzLZw9Z0f5l9UdzB9PXY6r1EFwGwVCF
 Yv+4x+zf5fiBVDnNxAyM75OkO8nyU+RTNnpHGUv1381RWl2bIau8uM9Pqof7LZMdSw
 exN6pBFSyjR/iR1bLKcZDH1xpt107/cIwLymZaHELPjxrVELRzZ6h6iQK+37QPHxVW
 9a7WDmS23PXknFdeSkwNMSmpPLGEjHfSVzPmiiWYWdf8WJLHQzjACZh/Qe56y9crB2
 C65DJsid/aTFA==
To: stable@vger.kernel.org
Date: Sun, 11 Oct 2026 12:48:14 -0400
Message-ID: <2026-10-11-1-daily-reply-0007-f2fs-pinfile-6-6@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261009112140.2275137-1-chao@kernel.org>
References: <20261009112140.2275137-1-chao@kernel.org>
MIME-Version: 1.0
X-Headers-End: 1xFwj5-0007wJ-6q
Subject: Re: [f2fs-dev] [PATCH RESEND 6.6.y 1/3] f2fs: fix to reclaim space
 in f2fs_allocate_pinning_section()
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
From: Sasha Levin via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Sasha Levin <sashal@kernel.org>
Cc: Sasha Levin <sashal@kernel.org>, Daeho Jeong <daehojeong@google.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-f2fs-devel@lists.sourceforge.net, jaegeuk@kernel.org, stable@kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

> It needs to trigger checkpoint to free space reclaimed by f2fs_gc_range(),
> otherwise, fallocate() on pinfile will fail easily even there is slash
> space in conventional zone.

Queued the series for 6.6, thanks.

-- 
Thanks,
Sasha


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
