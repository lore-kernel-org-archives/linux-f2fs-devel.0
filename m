Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEFAFC3ABB2
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 30 May 2025 08:01:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:To:Date:Message-ID:Sender:Cc:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=/fvGw+HukmNa+zishKEIMQQHBesd3rQT4sKL+Qgx/uw=; b=IpTdJw/Dvh6YSqrgbKeX84IFC/
	U1q4gEFU6li3x6KQu0hRgylA9DWNUPGTtnceKiq8Cft/QESSIExZuOFTUfiHLKI+HT8RfOlj+tr+2
	2akkntcB/e1BC7eIumS8C6miNt86Jsmzpt+zc2YQ+qdaemljSPod5nQWrD7f/+WjuvWs=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1uKugA-0007PT-Ax;
	Fri, 30 May 2025 08:01:26 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <adrian.liszka@novaplan.pl>) id 1uKug9-0007PF-26
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 30 May 2025 08:01:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:MIME-Version
 :Subject:To:From:Date:Message-ID:Sender:Reply-To:Cc:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=jxb0oDMobd7GaIcoqojTSF8ZoNcoVg4kM8ohJkoHKb8=; b=PZS5n7JssSAZiRVpyg3+CC4nER
 NW/XtXA60+/A7yVOivRcErYnHY6RvBM3Wf88fj01ox8jc5krXZ1WZrceUP+7/F/oniuUCWigf+/aB
 NcesfTHFL0V26N0Aarb01W4L99mkkTRD4BMsAwotAHMv9Okq+SjeO9gG8HndycSS4lNw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:To:From:Date:
 Message-ID:Sender:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=jxb0oDMobd7GaIcoqojTSF8ZoNcoVg4kM8ohJkoHKb8=; b=O
 UB0Blj0dwLXuFOZkqkEMn4qiB8VU7XvDvASeBmSC8XKZGKnxzwMBHgTOZ6xj5LCZCh/mLc9F6uH+b
 oSIuX2aFRHSKZUX1yHrd7YQFl+If03RyfA7GUdx4GjsGzf3avQ5aOYlossxQhAUe+Tn+IxCyumakr
 QyIGcwcqmwIFhgAQ=;
Received: from mail.novaplan.pl ([51.195.118.1])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1uKug8-0007Xe-AO for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 30 May 2025 08:01:24 +0000
Received: by mail.novaplan.pl (Postfix, from userid 1002)
 id 523C0A4ACA; Fri, 30 May 2025 10:00:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=novaplan.pl; s=mail;
 t=1748592052; bh=jxb0oDMobd7GaIcoqojTSF8ZoNcoVg4kM8ohJkoHKb8=;
 h=Date:From:To:Subject:From;
 b=CK/4YorfuH5IHWZKDbywVKu+XtreVWemmTO0DnHCDKdZLwlD05B5Wp6SDqz46/Crt
 XJ3KDRK4tKWxwoSD8tcFRgVHoEHzxwzwvkPq16V9rZNoaBOVMjvZcJzVtIrYydwPrL
 7F3GYRA8MELTFSnfCtCoAYKz08RVkdXO/Ajpr8ECC+r8WGSQwNd7G76kXWpO/W288U
 1UH4Wpiwg/37XxChlnR3p+BLNnwQvP0/s62Obgd9yfptoAnF3EBmwwqAIvCDntJZ3N
 VYvWvmn+MVYg3WZdnGFTEB2dux0+LysfIFoejt/uiTI0HgJLMdPSCTX+MKqVxC9Kni
 sFnuiw2GHi7mg==
Received: by mail.novaplan.pl for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri, 30 May 2025 08:00:41 GMT
Message-ID: <20250530084500-0.1.lv.22ca0.0.70cckzfn2d@novaplan.pl>
Date: Fri, 30 May 2025 08:00:41 GMT
To: <linux-f2fs-devel@lists.sourceforge.net>
X-Mailer: mail.novaplan.pl
MIME-Version: 1.0
X-Headers-End: 1uKug8-0007Xe-AO
Subject: [f2fs-dev] =?utf-8?q?Prosz=C4=99_o_kontakt?=
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
From: Adrian Liszka via Linux-f2fs-devel
 <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Adrian Liszka <adrian.liszka@novaplan.pl>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

RHppZcWEIGRvYnJ5LAoKQ3p5IGplc3QgbW/FvGxpd2/Fm8SHIG5hd2nEhXphbmlhIHdzcMOzxYJw
cmFjeSB6IFBhxYRzdHdlbT8KClogY2jEmWNpxIUgcG9yb3ptYXdpYW0geiBvc29ixIUgemFqbXVq
xIVjxIUgc2nEmSBkemlhxYJhbmlhbWkgendpxIV6YW55bWkgemUgc3ByemVkYcW8xIUuCgpQb21h
Z2FteSBza3V0ZWN6bmllIHBvenlza2l3YcSHIG5vd3ljaCBrbGllbnTDs3cuCgpaYXByYXN6YW0g
ZG8ga29udGFrdHUuCgoKWiBwb3pkcm93aWVuaWFtaQpBZHJpYW4gTGlzemthCgoKX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTGludXgtZjJmcy1kZXZlbCBt
YWlsaW5nIGxpc3QKTGludXgtZjJmcy1kZXZlbEBsaXN0cy5zb3VyY2Vmb3JnZS5uZXQKaHR0cHM6
Ly9saXN0cy5zb3VyY2Vmb3JnZS5uZXQvbGlzdHMvbGlzdGluZm8vbGludXgtZjJmcy1kZXZlbAo=
