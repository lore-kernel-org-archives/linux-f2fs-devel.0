Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 145DFCC6B2F
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 15 Oct 2026 08:41:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:Message-ID:MIME-Version:References:In-Reply-To:To:From:Date:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ZftCPohhv+UHRfhL4cVRBSl8mjKWp3nB9rXu6BbvSJ8=; b=QlllauAYBCjo+9D/nEWTlBWp01
	49xEXMFSXQNJ0nXaU5LwPl/d9RNpsZg2MTVWvRtlxbq7slxq0VuaOfwONNnQomDoeJxOYIz5FTeCr
	Osnhw5cKeoHHZ0DRD6A0t/gqQ5OSh9rhcFDytvkHI2uL88oq7pob5N2VJgg2+YrXWsLw=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xHH1k-0000zK-Gb;
	Thu, 15 Oct 2026 08:41:26 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <nzzhao@126.com>) id 1xHH1c-0000vl-3w
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 15 Oct 2026 08:41:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Message-ID:MIME-Version:Content-Type:
 Content-Transfer-Encoding:References:In-Reply-To:Subject:Cc:To:From:Date:
 Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=tdx46b4X8KT3uTDDgG01jx+zdIGIeM8B1mK4TlJVn4M=; b=bAQU+zsB9qztHXd6oIeI+sh8RV
 CRABbT8lTtxb1OZMP2gydn3l8NuAfQ8Ko/CbkExP8q3vj62RVQy13WKE7bqi83zYXHmw6gWpnx1CR
 RSaqGEv7p6BlUMEHU4gZFcZrOVMuLPoO2o4IkNsLTKU5SMWPHSfTt8JbBAUZP5EsKUjg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References
 :In-Reply-To:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=tdx46b4X8KT3uTDDgG01jx+zdIGIeM8B1mK4TlJVn4M=; b=KNvmKnl5XQzwPZ9oN3zlHBwrLR
 Iw7tIgxvv5jvg2OS8f1F3UBR3QMiiwQKbmocJGB5T2z6ejpwKgc4a7Z8drQ+yAmRhPAdl6QlIZOgH
 Keevfx/TllfGQcR/mPSLco8cyenXfN0YqjrQsgpXE2tuiUk+sd7q1/sTm1WGsRXJ33/Q=;
Received: from m16.mail.126.com ([117.135.210.8])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1xHH1U-0002iM-QC for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 15 Oct 2026 08:41:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
 s=s110527; h=Date:From:To:Subject:Content-Type:MIME-Version:
 Message-ID; bh=tdx46b4X8KT3uTDDgG01jx+zdIGIeM8B1mK4TlJVn4M=; b=V
 kseKGKnLBlcUzmjT94+Vscvtw3AEeOqO4xjrkw/ntV5BUROnMj2/E1XcmZ2yoe8n
 +4ejJR5F1WuH0X4vjdACyDazdiYEja6oMS/my8ev44mMRsju+PiWs+LfMiPzStqK
 5Z21S/Y6i6x8/z4bUT1MRhuF+0Uc0RJ53g2grkwmVA=
Date: Thu, 15 Oct 2026 16:40:29 +0800 (CST)
From: "Nanzhe Zhao" <nzzhao@126.com>
To: "Jaegeuk Kim" <jaegeuk@kernel.org>
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.4-cmXT build
 20260511(2e539873) Copyright (c) 2002-2026 www.mailtech.cn 126com
In-Reply-To: <atA24UMtAqkmz_R8@google.com>
References: <20261014064445.2835813-1-zhaonanzhe@xiaomi.com>
 <atAO6ykqwGgZq77y@google.com> <atA24UMtAqkmz_R8@google.com>
X-NTES-SC: AL_Qu2SAPyevE4p7yabYukdmEoVj+o8Xsaxs/8g2YJSc80Ooxvs5zIGU2d5Anvw/ei9Fi6BrjG2fgRi+th/Y6NKX1hlfeCqN0fUPJQN0mktSg==
MIME-Version: 1.0
Message-ID: <1d90a289.6797.1a13eb852cb.Coremail.nzzhao@126.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: cykvCgC3_299kdBqXiVQAA--.25521W
X-CM-SenderInfo: xq22xtbr6rjloofrz/xtbBsB1SImrQkX3B3wAA3V
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==
X-Headers-End: 1xHH1U-0002iM-QC
Subject: Re: [f2fs-dev] [PATCH v5 00/16] f2fs: support & optimize large
 folios for writable files
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
Cc: Nanzhe Zhao <nzzhao.sigma@gmail.com>, Barry Song <baohua@kernel.org>,
 linux-f2fs-devel@lists.sourceforge.net, Juan Yescas <jyescas@google.com>,
 Daeho Jeong <daehojeong@google.com>, Pengfei Li <lipengfei28@xiaomi.com>,
 Dev Jain <Dev.Jain@arm.com>, linux-kernel@vger.kernel.org,
 David Hildenbrand <David.Hildenbrand@arm.com>, Bo Zhang <zhangbo56@xiaomi.com>,
 Kalesh Singh <kaleshsingh@google.com>, Ryan Roberts <Ryan.Roberts@arm.com>,
 Nanzhe Zhao <zhaonanzhe@xiaomi.com>
Content-Type: text/plain; charset="gbk"
Content-Transfer-Encoding: base64
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

CkhpIEphZWd1azoKQXQgMjAyNi0xMC0xNSAxMDoxMzo1MywgIkphZWdldWsgS2ltIiA8amFlZ2V1
a0BrZXJuZWwub3JnPiB3cm90ZToKPk9rLCB0aGlzIGNvbWVzIHdoZW4gYXBwbHlpbmcgImYyZnM6
IGNhcnJ5IHN1YnBhZ2Ugb2Zmc2V0IGFuZCBjb3VudCBpbiB3cml0ZSBJTyIuCj4KPk9uIDEwLzE0
LCBKYWVnZXVrIEtpbSB2aWEgTGludXgtZjJmcy1kZXZlbCB3cm90ZToKPj4gSGkgTmFuemhlLAo+
PiAKPj4gQ291bGQgeW91IHBsZWFzZSBjaGVjayBJTyBzdWJtaXNzaW9uIHBhdGggZm9yIFpvbmVk
IGJsb2NrIGRldmljZT8KPj4gSSBoaXQgdGhpcy4KPj4gCj4+IFsgICA5My4xMDAyMjVdIHNkIDA6
MDowOjQ6IFJldHJ5aW5nIHVuYWxpZ25lZCB3cml0ZSBmb3Igem9uZSAyNjM5OyBvZmZzZXQgMjU5
NDQzMzEyOyB6b25lIG9mZnNldCAxOTA1NjsgSS9PIHNjaGVkdWxlciAobm9uZSk7IHJxIDAwMDAw
MDAwNjUzYjZhNzAgey5vcD1XUkkKPj4gWyAgIDkzLjEwMDQyMF0gc2QgMDowOjA6NDogUmV0cnlp
bmcgdW5hbGlnbmVkIHdyaXRlIGZvciB6b25lIDI2Mzk7IG9mZnNldCAyNTk0NDMzMTI7IHpvbmUg
b2Zmc2V0IDE5MDU2OyBJL08gc2NoZWR1bGVyIChub25lKTsgcnEgMDAwMDAwMDA2NTNiNmE3MCB7
Lm9wPVdSSQo+PiBbICAgOTMuMTAwNTUxXSBzZCAwOjA6MDo0OiBSZXRyeWluZyB1bmFsaWduZWQg
d3JpdGUgZm9yIHpvbmUgMjYzOTsgb2Zmc2V0IDI1OTQ0MzMxMjsgem9uZSBvZmZzZXQgMTkwNTY7
IEkvTyBzY2hlZHVsZXIgKG5vbmUpOyBycSAwMDAwMDAwMDY1M2I2YTcwIHsub3A9V1JJCj4+IFsg
ICA5My4xMDA5NDhdIHNkIDA6MDowOjQ6IFJldHJ5aW5nIHVuYWxpZ25lZCB3cml0ZSBmb3Igem9u
ZSAyNjM5OyBvZmZzZXQgMjU5NDQzMzEyOyB6b25lIG9mZnNldCAxOTA1NjsgSS9PIHNjaGVkdWxl
ciAobm9uZSk7IHJxIDAwMDAwMDAwNjUzYjZhNzAgey5vcD1XUkkKPj4gWyAgIDkzLjEwMTQzMl0g
c2QgMDowOjA6NDogUmV0cnlpbmcgdW5hbGlnbmVkIHdyaXRlIGZvciB6b25lIDI2Mzk7IG9mZnNl
dCAyNTk0NDMzMTI7IHpvbmUgb2Zmc2V0IDE5MDU2OyBJL08gc2NoZWR1bGVyIChub25lKTsgcnEg
MDAwMDAwMDA2NTNiNmE3MCB7Lm9wPVdSSQo+PiBbICAgOTMuMTAxNzYyXSBzZCAwOjA6MDo0OiBS
ZXRyeWluZyB1bmFsaWduZWQgd3JpdGUgZm9yIHpvbmUgMjYzOTsgb2Zmc2V0IDI1OTQ0MzMxMjsg
em9uZSBvZmZzZXQgMTkwNTY7IEkvTyBzY2hlZHVsZXIgKG5vbmUpOyBycSAwMDAwMDAwMDY1M2I2
YTcwIHsub3A9V1JJCj4+IFsgICA5My4xMDE5MDddIHNkIDA6MDowOjQ6IFJldHJ5aW5nIHVuYWxp
Z25lZCB3cml0ZSBmb3Igem9uZSAyNjM5OyBvZmZzZXQgMjU5NDQzMzEyOyB6b25lIG9mZnNldCAx
OTA1NjsgSS9PIHNjaGVkdWxlciAobm9uZSk7IHJxIDAwMDAwMDAwNjUzYjZhNzAgey5vcD1XUkkK
Pj4gWyAgIDkzLjEwMjU2NF0gc2QgMDowOjA6NDogUmV0cnlpbmcgdW5hbGlnbmVkIHdyaXRlIGZv
ciB6b25lIDI2Mzk7IG9mZnNldCAyNTk0NDMzMTI7IHpvbmUgb2Zmc2V0IDE5MDU2OyBJL08gc2No
ZWR1bGVyIChub25lKTsgcnEgMDAwMDAwMDA2NTNiNmE3MCB7Lm9wPVdSSQo+PiBbICAgOTMuMTAz
MDU0XSBzZCAwOjA6MDo0OiBSZXRyeWluZyB1bmFsaWduZWQgd3JpdGUgZm9yIHpvbmUgMjYzOTsg
b2Zmc2V0IDI1OTQ0MzMxMjsgem9uZSBvZmZzZXQgMTkwNTY7IEkvTyBzY2hlZHVsZXIgKG5vbmUp
OyBycSAwMDAwMDAwMDY1M2I2YTcwIHsub3A9V1JJCj4+IFsgICA5My4xMDM0NDddIHNkIDA6MDow
OjQ6IFJldHJ5aW5nIHVuYWxpZ25lZCB3cml0ZSBmb3Igem9uZSAyNjM5OyBvZmZzZXQgMjU5NDQz
MzEyOyB6b25lIG9mZnNldCAxOTA1NjsgSS9PIHNjaGVkdWxlciAobm9uZSk7IHJxIDAwMDAwMDAw
NjUzYjZhNzAgey5vcD1XUkkKPj4gWyAgIDkzLjEwMzY2N10gc2QgMDowOjA6NDogUmV0cnlpbmcg
dW5hbGlnbmVkIHdyaXRlIGZvciB6b25lIDI2Mzk7IG9mZnNldCAyNTk0NDMzMTI7IHpvbmUgb2Zm
c2V0IDE5MDU2OyBJL08gc2NoZWR1bGVyIChub25lKTsgcnEgMDAwMDAwMDA2NTNiNmE3MCB7Lm9w
PVdSSQo+PiBbICAgOTMuMTA0Mjk0XSBzZCAwOjA6MDo0OiBSZXRyeWluZyB1bmFsaWduZWQgd3Jp
dGUgZm9yIHpvbmUgMjYzOTsgb2Zmc2V0IDI1OTQ0MzMxMjsgem9uZSBvZmZzZXQgMTkwNTY7IEkv
TyBzY2hlZHVsZXIgKG5vbmUpOyBycSAwMDAwMDAwMDY1M2I2YTcwIHsub3A9V1JJCj4+IFsgICA5
My4xMDQzNzNdIHNkIDA6MDowOjQ6IFJldHJ5aW5nIHVuYWxpZ25lZCB3cml0ZSBmb3Igem9uZSAy
NjM5OyBvZmZzZXQgMjU5NDQzMzEyOyB6b25lIG9mZnNldCAxOTA1NjsgSS9PIHNjaGVkdWxlciAo
bm9uZSk7IHJxIDAwMDAwMDAwNjUzYjZhNzAgey5vcD1XUkkKPj4gWyAgIDkzLjEwNDQ0OV0gc2Qg
MDowOjA6NDogUmV0cnlpbmcgdW5hbGlnbmVkIHdyaXRlIGZvciB6b25lIDI2Mzk7IG9mZnNldCAy
NTk0NDMzMTI7IHpvbmUgb2Zmc2V0IDE5MDU2OyBJL08gc2NoZWR1bGVyIChub25lKTsgcnEgMDAw
MDAwMDA2NTNiNmE3MCB7Lm9wPVdSSQo+PiBbICAgOTMuMTA1MjIwXSBzZCAwOjA6MDo0OiBSZXRy
eWluZyB1bmFsaWduZWQgd3JpdGUgZm9yIHpvbmUgMjYzOTsgb2Zmc2V0IDI1OTQ0MzMxMjsgem9u
ZSBvZmZzZXQgMTkwNTY7IEkvTyBzY2hlZHVsZXIgKG5vbmUpOyBycSAwMDAwMDAwMDY1M2I2YTcw
IHsub3A9V1JJCj4+IFsgICA5My4xMDUyNTNdIHNkIDA6MDowOjQ6IFJldHJ5aW5nIHVuYWxpZ25l
ZCB3cml0ZSBmb3Igem9uZSAyNjM5OyBvZmZzZXQgMjU5NDQzMzEyOyB6b25lIG9mZnNldCAxOTA1
NjsgSS9PIHNjaGVkdWxlciAobm9uZSk7IHJxIDAwMDAwMDAwNjUzYjZhNzAgey5vcD1XUkkKPj4g
WyAgIDkzLjEwNTUzMl0gc2QgMDowOjA6NDogUmV0cnlpbmcgdW5hbGlnbmVkIHdyaXRlIGZvciB6
b25lIDI2Mzk7IG9mZnNldCAyNTk0NDMzMTI7IHpvbmUgb2Zmc2V0IDE5MDU2OyBJL08gc2NoZWR1
bGVyIChub25lKTsgcnEgMDAwMDAwMDA2NTNiNmE3MCB7Lm9wPVdSSQoKQ291bGQgeW91IHRlbGwg
bWUgd2hpY2ggbGluZSBvZiBjb2RlIHByaW50cyB0aGlzIGxvZ6O/IEkndmUgZm91bmQgYSBiaXQg
ZGlmZmljdWx0IHRvIGZpbmQgaW4gbXkgZjJmcyBkZXYtdGVzdCBrZXJuZWwgdHJlZSBhbmQgcGl4
ZWwgYW5kcm9pZCBtYWlubGluZSBrZXJuZWwgdHJlZS4uCgpUaGFua3MsCk5hbnpoZQoKCgpfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpMaW51eC1mMmZzLWRl
dmVsIG1haWxpbmcgbGlzdApMaW51eC1mMmZzLWRldmVsQGxpc3RzLnNvdXJjZWZvcmdlLm5ldApo
dHRwczovL2xpc3RzLnNvdXJjZWZvcmdlLm5ldC9saXN0cy9saXN0aW5mby9saW51eC1mMmZzLWRl
dmVsCg==
