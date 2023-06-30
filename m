Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87C77C001DB
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 30 Jun 2023 23:40:36 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1qFNj9-00081Q-7o;
	Fri, 30 Jun 2023 23:40:35 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1qFNj4-00081A-GB
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 30 Jun 2023 23:40:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:
 Subject:Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=xfCqkfkyS3Q3lDu61VHA2tzzNuB7RyXsw+1cx8fKKeA=; b=ixniQc6BtYhdkGFiM4Yc5Bqyk/
 bUW+k4Bgdp7LnLzAf/Uu+piEp6orVsHDc3NgTHVJjXZREVLZqBmvl4U0eDY0NdazTmzR3bcKoMhss
 YkpKvuzTV5Uj8Jab2tk/VxN+IVm/1NAbxdfEomnNWFeEwSpga+qE52FQm5wrI0jnHXjc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=xfCqkfkyS3Q3lDu61VHA2tzzNuB7RyXsw+1cx8fKKeA=; b=hWqR12wx+iItxrokoaqwCzwKhx
 9UDgWz9Jz0+g5zAqKxh8GeZJt3MFxWSNal+pZavQE5DhctZN9I4ldIsGUo0IWEJcn2GGi8KNqi7+A
 hR94KwrYcT0WcMQIW3BN/KNSEQ2iYfhNTsR5aI9QHb6dGBowhN8+Gycgruiu9txNEVP0=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1qFNj4-002Wkl-5c for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 30 Jun 2023 23:40:30 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id B9C7E61843
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri, 30 Jun 2023 23:40:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9C6CEC433D9;
 Fri, 30 Jun 2023 23:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1688168423;
 bh=MUL3HpynqrN8NXdFIHKVH4ua0Im3yKJVHftqI1IB12M=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
 b=c+z+1Nzpgg3utPqW7eXVKec7CL6/wio8T75TJuSTVfW91nK0qXy35Lby5VWka6hkW
 93PzCl5zuA2LxfeJ10LwZY8dDc4J+eeAoV6SHnwzeAvccPMDQ1zZE2R2mPrTq1zHl9
 ZPvpHV4L91Ws5V0lNTkpXWXJj4wUk9sdLgouzYVbdhro/Iiu7ij5aaJj5Z0iSZAw91
 XZn9i/irTqDBnnnZoWyPXunkDFT3nTo3Wgg+UCtBnlp3MBlv8WXtunlSqwmkRrajx+
 9oJ/7WYahlTcSqdWqxN5NsJ1PHJZNpfWX+HbaFMiBsB6m2mOxXax4AOHMAA/q9uRWs
 xECfiyQeacFWA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id
 74606C6445B; Fri, 30 Jun 2023 23:40:23 +0000 (UTC)
MIME-Version: 1.0
From: patchwork-bot+f2fs@kernel.org
Message-Id: <168816842347.31915.15373358739208478916.git-patchwork-notify@kernel.org>
Date: Fri, 30 Jun 2023 23:40:23 +0000
References: <20230629014134.3058318-1-chao@kernel.org>
In-Reply-To: <20230629014134.3058318-1-chao@kernel.org>
To: Chao Yu <chao@kernel.org>
X-Headers-End: 1qFNj4-002Wkl-5c
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix compile warning in
 f2fs_destroy_node_manager()
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
Cc: jaegeuk@kernel.org, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

SGVsbG86CgpUaGlzIHBhdGNoIHdhcyBhcHBsaWVkIHRvIGphZWdldWsvZjJmcy5naXQgKGRldikK
YnkgSmFlZ2V1ayBLaW0gPGphZWdldWtAa2VybmVsLm9yZz46CgpPbiBUaHUsIDI5IEp1biAyMDIz
IDA5OjQxOjM0ICswODAwIHlvdSB3cm90ZToKPiBmcy9mMmZzL25vZGUuYzogSW4gZnVuY3Rpb24g
4oCYZjJmc19kZXN0cm95X25vZGVfbWFuYWdlcuKAmToKPiBmcy9mMmZzL25vZGUuYzozMzkwOjE6
IHdhcm5pbmc6IHRoZSBmcmFtZSBzaXplIG9mIDEwNDggYnl0ZXMgaXMgbGFyZ2VyIHRoYW4gMTAy
NCBieXRlcyBbLVdmcmFtZS1sYXJnZXItdGhhbj1dCj4gIDMzOTAgfCB9Cj4gCj4gTWVyZ2luZyBi
ZWxvdyBwb2ludGVyIGFycmF5cyBpbnRvIGNvbW1vbiBvbmUsIGFuZCByZXVzZSBpdCBieSBjYXN0
IHR5cGUuCj4gCj4gc3RydWN0IG5hdF9lbnRyeSAqbmF0dmVjW05BVFZFQ19TSVpFXTsKPiBzdHJ1
Y3QgbmF0X2VudHJ5X3NldCAqc2V0dmVjW1NFVFZFQ19TSVpFXTsKPiAKPiBbLi4uXQoKSGVyZSBp
cyB0aGUgc3VtbWFyeSB3aXRoIGxpbmtzOgogIC0gW2YyZnMtZGV2XSBmMmZzOiBmaXggY29tcGls
ZSB3YXJuaW5nIGluIGYyZnNfZGVzdHJveV9ub2RlX21hbmFnZXIoKQogICAgaHR0cHM6Ly9naXQu
a2VybmVsLm9yZy9qYWVnZXVrL2YyZnMvYy9jMzFlNDk2MTU3NjIKCllvdSBhcmUgYXdlc29tZSwg
dGhhbmsgeW91IQotLSAKRGVldC1kb290LWRvdCwgSSBhbSBhIGJvdC4KaHR0cHM6Ly9rb3JnLmRv
Y3Mua2VybmVsLm9yZy9wYXRjaHdvcmsvcHdib3QuaHRtbAoKCgoKX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTGludXgtZjJmcy1kZXZlbCBtYWlsaW5nIGxp
c3QKTGludXgtZjJmcy1kZXZlbEBsaXN0cy5zb3VyY2Vmb3JnZS5uZXQKaHR0cHM6Ly9saXN0cy5z
b3VyY2Vmb3JnZS5uZXQvbGlzdHMvbGlzdGluZm8vbGludXgtZjJmcy1kZXZlbAo=
