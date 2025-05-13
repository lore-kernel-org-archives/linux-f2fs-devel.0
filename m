Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D3FBC3ABC3
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 13 May 2025 07:56:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:To:Date:Message-ID:Sender:Cc:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=/d1q0MzNmRelDxIjIyOb81zE2TzPzoXkRIdVqOjJaJg=; b=bUQk1+a7FDhK/yO+kG9s85kL/m
	VyWYYGHMPD86gTsf660WJcqbTAId9VweQiJpxWR84NX/MiVLXCTOVsh181fr8KYo+lxuLXCgGsptm
	g2FXAlZq5tKFWMA8dR6RxgMlHGjZTIaltHkkXSO7uuC5xGBEYJPIj+mYDC4kVgnoOjtI=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1uEkVE-0000gA-AO;
	Tue, 13 May 2025 07:56:40 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <samuel.zeman@formbizup.com>) id 1uEkVD-0000g3-53
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 13 May 2025 07:56:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:MIME-Version
 :Subject:To:From:Date:Message-ID:Sender:Reply-To:Cc:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=wAcXwrNiqDJpeutFZq0A35YRxAPArSLzCPVOyFH7y18=; b=hiZFXdPLxgRcoer3Jd2qn9j4hD
 tAkxG0yOrxdYxxICNh8WhG9iIfpIYJCqt/fs174TVRrUAyslvHQNnVSZjbwM7azpG3zX0e4yZnnHb
 QlbkGxxkNKQl76OkEJpI+/pg03w3xLv42BYI4SgT1yhT65XNeSTSrczW86JdvUlK8TmE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:To:From:Date:
 Message-ID:Sender:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=wAcXwrNiqDJpeutFZq0A35YRxAPArSLzCPVOyFH7y18=; b=D
 wH+dU9VndG4Mr8DLkO1l55BID7dmGjMVpqrguy7EIxdgyqqqDOSwmHZfbeg+Qxt1AamVBysipy+sT
 ooxiCfXLCk6rRs0PQvkRtV5QyGMWWzJyVQfqp68MmaCUjmowKFiKYH/Y92onDJu5zckqv9Ewoiz5j
 fpm2AqHWZTApGH6I=;
Received: from mail.formbizup.com ([51.195.200.90])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1uEkVB-0004Wx-VF for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 13 May 2025 07:56:39 +0000
Received: by mail.formbizup.com (Postfix, from userid 1002)
 id 56E054D71D; Tue, 13 May 2025 09:56:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=formbizup.com;
 s=mail; t=1747122986;
 bh=wAcXwrNiqDJpeutFZq0A35YRxAPArSLzCPVOyFH7y18=;
 h=Date:From:To:Subject:From;
 b=WM5ExUVbrTAJ26QQxlKEVt0LcU6chnQ2fMeVht1EOCHQBJ7eBmTpT7kZWRVSTgubO
 ftDZcHpZ1zG6EHuAsEfKrNecrV69CCmd4E7hmDk2nofLJemhKzcb4HXor7AhCpScNK
 3g68ho20HOGqep8ykSDmElVuCYGnkjCGNL3Q0QYs1RFlVWb73RQAPbooSS15R0etVV
 ts0yoS7zd5xpX3Q1E67uMPJK4JVtkUT9brBvwYHao3S48A19MAl+vzChkEQiB8lL3x
 6/BxZmfHYXSV9cZ3nRuF84fdh+8uDiDrdNKJfva2mdusFTp008G9Fy9Wkb9rMnJz4D
 RkTExb4s1mc9w==
Received: by mail.formbizup.com for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 13 May 2025 07:56:15 GMT
Message-ID: <20250513084500-0.1.98.o9w9.0.9p99gfjlz7@formbizup.com>
Date: Tue, 13 May 2025 07:56:15 GMT
To: <linux-f2fs-devel@lists.sourceforge.net>
X-Mailer: mail.formbizup.com
MIME-Version: 1.0
X-Headers-End: 1uEkVB-0004Wx-VF
Subject: [f2fs-dev] =?utf-8?q?Spolupr=C3=A1ce_s_dovozcem?=
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
From: Samuel Zeman via Linux-f2fs-devel
 <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Samuel Zeman <samuel.zeman@formbizup.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

RG9icsO9IGRlbiwKCnphc3R1cHVqaSBzcG9sZcSNbm9zdCBzcGVjaWFsaXp1asOtY8OtIHNlIG5h
IGRvdm96IHBhcMOtcmVuc2vDqWhvLCDFoWtvbG7DrWhvIGEga2FuY2Vsw6HFmXNrw6lobyB6Ym/F
vsOtLCBrcmVhdGl2bsOtY2ggcG90xZllYiwgZGVrb3JhY8OtIGEgc2V6w7NubsOtY2ggKHbDoW5v
xI1uw61jaCkgcHJvZHVrdMWvLgoKViBuYcWhw60gbmFiw61kY2UgbmFqZGV0ZSBhxb4gMzAwMCBw
ZcSNbGl2xJsgdnlicmFuw71jaCBwcm9kdWt0xa8sIGt0ZXLDqSBqc291IGlkZcOhbG7DrSBwcm8g
dmVsa29vYmNob2Ruw60gcHJvZGVqLgoKViBzb3XEjWFzbm9zdGkgb2JzbHVodWplbWUgdsOtY2Ug
bmXFviA0MjUgesOha2F6bsOta8WvIHYgdHV6ZW1za3UgaSB6YWhyYW5pxI3DrSwgY2/FviBzdsSb
ZMSNw60gbyBuYcWhw60gc3BvbGVobGl2b3N0aSBhIMWhaXJva8OpbSBkb3NhaHUuCgpKYWtvIHDF
mcOtbcO9IGRvdm96Y2UgbcWvxb5lbWUgbmFiw61kbm91dCBrb25rdXJlbmNlc2Nob3Buw6kgY2Vu
eSBiZXogcHJvc3TFmWVkbsOta8WvLCBhdHJha3Rpdm7DrSBsb2dpc3RpY2vDqSBwb2Rtw61ua3kg
KG1pbmltw6FsbsOtIG9iamVkbsOhdmthIG9kIDEwMDAgS8SNIGJleiBEUEgpIGEgdsSNYXNuw6kg
dnnFmcOtemVuw60gb2JqZWRuw6F2ZWsuCgpQb2t1ZCBobGVkw6F0ZSBwYXJ0bmVyYSBzIMWhaXJv
a291IG5hYsOtZGtvdSBwcm9kdWt0xa8gYSB2w71ob2Ruw71taSBwb2Rtw61ua2FtaSBzcG9sdXBy
w6FjZSwgcsOhZGkgcHJvIHbDoXMgcMWZaXByYXbDrW1lIG5hYsOtZGt1IMWhaXRvdSBuYSBtw61y
dS4KClTEm8Whw61tZSBzZSBuYSBtb8W+bm9zdCBuYXbDoXrDoW7DrSDDunNwxJvFoW7DqSBzcG9s
dXByw6FjZSEKCgpTIHDFmcOhdGVsc2vDvW0gcG96ZHJhdmVtClNhbXVlbCBaZW1hbgoKCl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkxpbnV4LWYyZnMtZGV2
ZWwgbWFpbGluZyBsaXN0CkxpbnV4LWYyZnMtZGV2ZWxAbGlzdHMuc291cmNlZm9yZ2UubmV0Cmh0
dHBzOi8vbGlzdHMuc291cmNlZm9yZ2UubmV0L2xpc3RzL2xpc3RpbmZvL2xpbnV4LWYyZnMtZGV2
ZWwK
