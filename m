Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 116F4CD98DA
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 15 Jun 2026 19:37:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:References:
	Message-ID:To:Date:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ETNaagokaLQyxmv7yRrjfLlpfnDi+9Eb3Zv9fAoEEnA=; b=AyegoBzX7htZF3XNZhFsww7Pse
	8rzy/YU9nOt1d/1/Badkt2MmhmdjWQjhKZStnQgnfc3sDMnTvr7p2RotUtsZWX9ci24+1tgg7UB/k
	6jlWDD3HHdvjn/p4Ht2ehwQYX7ssernF5bgkF1LHcAZ/xk7ZBSkoprMyl+H4FauSGdrw=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wZD7v-0005Gd-LQ;
	Mon, 15 Jun 2026 19:37:43 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <ebiggers@kernel.org>) id 1wZD7u-0005GX-2Z
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 15 Jun 2026 19:37:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=xzdaAZ3vb4ixL+pONGkgMZtFCmR6/l4XZZFEzZGSXuw=; b=Z2Y4VZB6xD8xHSniQKxdQu++Bb
 FW92YysvyrKdFrsAwi5ae+SxZaL+txBw6Zu641Wb8PJFE78BVIIbIorfuzGoHVeRtL9hP3hHv6BrL
 LxVou5jRWo86glSPbS50A6oiQK+RgXJkZdQK0GSULAhAftHRhIq1C4OABb09XDUR8vZI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=xzdaAZ3vb4ixL+pONGkgMZtFCmR6/l4XZZFEzZGSXuw=; b=JVGfi1FQevC7ijkl/HwL8m1+hv
 qPdOHk4C4F6wHXloemZkpLqkrfM2wWy706CiacBr6eYTf7qpGD4VdtNMMkHr8a2ZzsiqSmhx8bGUi
 WM9o5HvaBq4rALD3AsFP36Y54dedRhur6N6w+Sj+/6F/IDGiE5KTM4cuhs/9JoE24e5k=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wZD7s-00014z-2l for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 15 Jun 2026 19:37:42 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id E8D2F601EE;
 Mon, 15 Jun 2026 19:37:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 517DE1F00A3D;
 Mon, 15 Jun 2026 19:37:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781552249;
 bh=xzdaAZ3vb4ixL+pONGkgMZtFCmR6/l4XZZFEzZGSXuw=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=mR7l6UIzq1yljDBgRBwGWbw5sYLRrGC/WtvkE6SS1PAidXXsnZEn+S63G5twdMRi1
 tkMAhkksazmcTnUO3XTiSRoX0qPLh6tVMghb0F8gWQQ6+rYsRxv+/UDr3lzVHGJziJ
 CdNU4fXWHatiGntbD6Ged4oN1G0fNn+NiepqyRX1IuTpY17MoC0P7JprMR3gVOECH1
 dIt5Lx38vRPQO8QQAAD+g7sqyRpMwT4mEMV+C1iHo2hN/LDHEhSWpTB5HqA9ny+4NB
 OIw6nzUQQSzF65/Qid/VMmOxJ6dlPsniJriBQdC1VnhZFR5so2royamQRNAchAGqik
 NNtZ7gYGvC75w==
Date: Mon, 15 Jun 2026 12:37:28 -0700
To: LiaoYuanhong-vivo <liaoyuanhong@vivo.com>
Message-ID: <20260615193728.GA1764@quark>
References: <20260615125517.362294-1-liaoyuanhong@vivo.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260615125517.362294-1-liaoyuanhong@vivo.com>
X-Headers-End: 1wZD7s-00014z-2l
Subject: Re: [f2fs-dev] [PATCH v3 0/3] f2fs: support encrypted inline data
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
From: Eric Biggers via Linux-f2fs-devel
 <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Eric Biggers <ebiggers@kernel.org>
Cc: "Theodore Y. Ts'o" <tytso@mit.edu>, Jonathan Corbet <corbet@lwn.net>,
 "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>,
 "open list:F2FS FILE SYSTEM" <linux-f2fs-devel@lists.sourceforge.net>,
 "open list:FSCRYPT: FILE SYSTEM LEVEL ENCRYPTION SUPPORT"
 <linux-fscrypt@vger.kernel.org>, Shuah Khan <skhan@linuxfoundation.org>,
 Jaegeuk Kim <jaegeuk@kernel.org>, linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

[+Cc linux-ext4@vger.kernel.org]

On Mon, Jun 15, 2026 at 08:55:12PM +0800, LiaoYuanhong-vivo wrote:
> F2FS currently disables inline data for encrypted regular files because the
> inline payload is stored in the inode block and does not go through the
> regular bio-based fscrypt path.  This wastes space for small encrypted
> files on Android devices using F2FS inlinecrypt.
> 
> This series adds an encrypted_inline_data on-disk feature for F2FS.
> With this feature enabled, encrypted regular files may keep small contents
> in the inode block.  The inline payload is encrypted before being stored in
> the inode and decrypted back into page-cache plaintext on read.
> 
> The fscrypt changes are scoped to filesystem-managed data-unit crypto.
> F2FS first asks fscrypt whether the inode's key/policy supports this path.
> It prepares the software transform only when encrypted inline payloads are
> read or written.  Inlinecrypt support is limited to v2 IV_INO_LBLK_64 and
> IV_INO_LBLK_32 policies, including the hardware-wrapped key configurations
> supported by fscrypt.  Per-file inlinecrypt keys and DIRECT_KEY policies
> are not supported for encrypted inline data.

I still think we should hold off on this, for the reasons I gave at
https://lore.kernel.org/r/20260515184124.GA4903@quark/

As soon as you start using hardware-wrapped keys this will become
irrelevant, as it can't be used in that case.  I see you added "support"
for that case anyway by deriving contents encryption keys from the
sw_secret.  But that bypasses the security model, which isn't okay.

I'm also working to simplify ext4 and f2fs's file contents encryption
implementation by standardizing on blk-crypto.  That aligns well with
what btrfs encryption is going to do as well.  So this isn't a great
time to be making f2fs's file contents encryption implementation even
more complex by going in a different direction.

If there was demand for this feature from the ext4 side for
general-purpose Linux distros as well, that would make it a bit more
appealing, as it would show broader demand.  But with the proposal being
f2fs-specific and effectively just for Android devices that *don't* use
wrapped keys, that feels too narrow for the added complexity.

This proposal also lacks test cases in xfstests and/or Android's
vts_kernel_encryption_test that verify that the inline data is actually
being encrypted correctly.  Those tests are essential, and we *must not*
add new file contents encryption implementations without such tests.

- Eric


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
