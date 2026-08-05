Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFC74C55ABF
	for <linux-f2fs-devel@archiver.kernel.org>; Wed,  5 Aug 2026 21:21:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:To:In-Reply-To:References:Date:Message-Id:
	MIME-Version:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=VRrR3VzFlwXgSbDzA5TV92/YZ7P0aPAAF0N4wIGbZ+g=; b=A1seuH9R04g8yL0m0EWMreIgsn
	cjA0po/If2MgQYyg4U2xPstyZTeryKIVJsJKjrx+8nMN+zGSkJ947fZUiiML4VIh/avzujLIyBM+9
	+c+bZGK9pDs5TrBnYxD+MGNca7SUvnEZa26PYXJpnYshW17VAlYmKTcBY0lfiA3nwy5w=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wrj3g-0003G0-7V;
	Wed, 05 Aug 2026 21:21:52 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1wrj3e-0003Fi-9m
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 05 Aug 2026 21:21:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:
 Subject:Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=kVrdpT7mWkB1LXBMIfBihO9UlZb9xRKyVf0KIbHuGSQ=; b=mqeU6HFbmk0+fDPJ6q6CF0I774
 LzF4dryWps0XhXo3XtChIHQAjvqJg+s4X8S8Mp9rJczbZIQ79pXrmqpSNiTdjuhrKp2P5Uo4qfJnn
 5qzrm9hDpP6wj9MdH7jTTqrHl8cEUehc/ivK+zeFUmL8p9DOvVRdmGeiMk143MtyQJcE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=kVrdpT7mWkB1LXBMIfBihO9UlZb9xRKyVf0KIbHuGSQ=; b=Fw1gbjMY7m4hMZqnvgPJy2WxMA
 CNUc+3ENzsto2vl5OUk/w37e5bvA/BfPqiwoYD81cB9ZwPK3teuOH3Y8jlsIvlNHk2gu3Z/+02cAM
 C6HFXobf5vLKu+oIU2/gLz6XEJFFIZn6HKKSjjlKozZpOTdVrtcEI3d8IkQFm4FNb9UM=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wrj3g-00044w-FM for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 05 Aug 2026 21:21:49 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 5FDC060A80;
 Wed,  5 Aug 2026 21:21:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 155A91F00A3A;
 Wed,  5 Aug 2026 21:21:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785964903;
 bh=kVrdpT7mWkB1LXBMIfBihO9UlZb9xRKyVf0KIbHuGSQ=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc;
 b=B5/pu1BJXxDv0BDXujLOnnm4Io0TL8IlYzxELIqrIFqhcvD6pVpizSQPXlV3viKtP
 HcyOspJmu+ger92MfwWUR51DG2CijrN2khcYVjKdDJ7Fr9Mhnm27Ht+lm+1DYWGq6n
 ZwMKk4HB8ePhSJ8kckof4jXVarLz7Xb+ysVyaXUBpq/K6Y7I2pOG2ixHtx8w7CdPMD
 lYEl1Rs1Us/TRMUu3biyr2XI8nPTFp1J99GHuzHUq1H04Kzt4hPLWLAGD8pDc4rPuC
 rnNkB+b5kxzesT+1k2SbYMPLtr7mZW2FhI9VBEql7eoDJbxnfhfwcO7Yu/uV293cPA
 AUuUpl8CarvGQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
 by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 19845392FFD1; Wed,  5 Aug 2026 21:21:04 +0000 (UTC)
MIME-Version: 1.0
Message-Id: <178596486263.530543.12202938187333968046.git-patchwork-notify@kernel.org>
Date: Wed, 05 Aug 2026 21:21:02 +0000
References: <20260630082331.2757376-1-qiwenjie@xiaomi.com>
In-Reply-To: <20260630082331.2757376-1-qiwenjie@xiaomi.com>
To: Wenjie Qi <qwjhust@gmail.com>
X-Headers-End: 1wrj3g-00044w-FM
Subject: Re: [f2fs-dev] [PATCH] f2fs: limit recovery filename logging to
 stored length
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
From: patchwork-bot+f2fs--- via Linux-f2fs-devel
 <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: patchwork-bot+f2fs@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 qiwenjie@xiaomi.com, jaegeuk@kernel.org, stable@kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Tue, 30 Jun 2026 16:23:30 +0800 you wrote:
> F2FS stores recovery filenames as a length plus a fixed-size i_name
> buffer.  The buffer is not NUL-terminated, but recover_inode() and
> recover_dentry() print it with %s.
> 
> For a 255-byte filename, recovery logging can read past i_name into the
> following raw inode fields.
> 
> [...]

Here is the summary with links:
  - [f2fs-dev] f2fs: limit recovery filename logging to stored length
    https://git.kernel.org/jaegeuk/f2fs/c/01027b2fcb74

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
