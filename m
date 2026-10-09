Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE4ADCA6019
	for <linux-f2fs-devel@archiver.kernel.org>; Fri,  9 Oct 2026 10:21:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:To:Message-ID:Mime-Version:Date:Sender:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=h9acq0g+rzHQDidO8fiM2l0LNRZ8GOQS439ZijtYLxY=; b=XObis/d8dGeHjakZnvMIYIU6IS
	JEaSi4qgI9VzSRUkRHQw+nCdDVtwV3p+77K/pJeMg3tt3sGJGFoIyjYRVb71b75PD7SnDLyEht1TH
	r+ncC1rzFwCYrE7jFZbN9qwC6n+reRRwPW3DiQbgvtYaar0ccxlmStpgaqILz9v4uSCc=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xF7jE-0004ml-QG;
	Fri, 09 Oct 2026 10:21:29 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95) (envelope-from
 <3sLnIagsKAKMMRDQQHFKLHQJRRJOH.FRP@flex--joannechien.bounces.google.com>)
 id 1xF7jC-0004me-QI for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 09 Oct 2026 10:21:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:Cc:To:From:
 Subject:Message-ID:Mime-Version:Date:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=z5mwkjVbumujA82oUW/bPPHdhu5bBK7+OscTTg1epec=; b=HjqKkjO/jhbARiEbd0ASP8UlY4
 Yf559LAEiEtRJsr9IBvkA9xeqWAroRCaAWEWOrcy3ajDn45464GEfslEsuzER6Wb5Q1T2vIKoFjiy
 wNHDFOqvsr4IX0NvTNqSbHzxhHFL2MKM5Q0Jtj1It8ewwD8tuYwv5nmu6VaA0ObLEHxg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:Cc:To:From:Subject:Message-ID:
 Mime-Version:Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=z5mwkjVbumujA82oUW/bPPHdhu5bBK7+OscTTg1epec=; b=d
 2yYLQD0uJAF++Wz1mVIrje/YXwSMs2NHjNzk2yBEuVHw5d671fe3NRB82F5EBLYEqIn3Q2Cn7nPbq
 c85sMceLcH9xwsahxObmTI9Tk3KmIRLQdrbmrQtC6HEKpxJOt42GsQSN27Kpo4XGzrau86XeUlxmL
 YS540BN4/lTMWNWw=;
Received: from mail-oa1-f72.google.com ([209.85.160.72])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xF7jB-00061z-V1 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 09 Oct 2026 10:21:27 +0000
Received: by mail-oa1-f72.google.com with SMTP id
 586e51a60fabf-49dd26d6f07so6523797fac.0
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri, 09 Oct 2026 03:21:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1791541280; x=1792146080;
 darn=lists.sourceforge.net; 
 h=content-transfer-encoding:content-type:cc:to:from:subject
 :message-id:mime-version:date:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=z5mwkjVbumujA82oUW/bPPHdhu5bBK7+OscTTg1epec=;
 b=MkRpcIuIcgHVjV1dVaABxO+1NZ96W1BaRsGiPf8JsHaxFsHG9WsQeWIYdjhOqcJiur
 jSiYKPxpink5Kz/jiSF46nbyp/vy8iZFah6jBrncYEY6SytLDS6K/8kTdXvCn4aw8Q5I
 sP4Sn6krn/WYxzMrLlRP35Vzhs32tQxp4KRaszM8voFQ9mh0P2k9drm9OyXXRpP0WDzS
 mkqIwDgehF1XnseFqyJeMz6sWebVOtAciWmwIcxjSVj5XvhlYq1xekjohE7nxML8dtn6
 7uJpm0j/UTsoPX7OPlJxF2PP1HZTuUkd7L25RTpRyHoz8y2o1b4wVJOJx4+Vf5kW+zU5
 wjvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791541280; x=1792146080;
 h=content-transfer-encoding:content-type:cc:to:from:subject
 :message-id:mime-version:date:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=z5mwkjVbumujA82oUW/bPPHdhu5bBK7+OscTTg1epec=;
 b=e+92UQd9zMO90FsLarBiKsFZQ+IPbA9lrVuDBVdxZ8eg2kQJAUTzoNO3+JMCYcuTWV
 KXX7ncijrPk0wQzjM6uEtWEl9+MNUWkQMlVMoed4WJIoPT8dzPNu0o4g9rk/p9AOQWpm
 2ASShke4+lRFWn+frjxDPfIRa0CMKqXIDtwZKlWZ4QkBhUOYctROgqDuiO7hvtl6KxXD
 kP5D1ybe3K3oxDT913jJxqaHnXvfmC4TaWPTs3ATTpgyQ0xxKEwKm6wObkAjmqYVmyJq
 kXdjZR7SJjkFEwHV5CgA9z7NM6Hc+PrHjXr+fw073ZliOfjspC7lgXSWzbpUM8/ukMlv
 zHzw==
X-Forwarded-Encrypted: i=1;
 AKwUvBzq9jzKvvDKq8HOEuh9v3RGG79hLj+hVngGdrUu/WLmEwsAICKSHHrvLd3cC9acGbQ9929oU3/dVpwGsG9uIXAc@lists.sourceforge.net
X-Gm-Message-State: AFq9FYJBHVhTbBxtbaRS05B8LQR8lH6x/dWqXC2bzrNU5MlYfKPX3yq3
 ivIHBZhZeVnURrPgh9SpmhvQhvU1S3AIo7OmAEg0bcaaMKotacrx/QMRsN1Sk6XFTszi6VviDXG
 AjYc/3tCv2GAfaplpd3J9FioQKA==
X-Received: from pfbbk6.prod.google.com ([2002:aa7:8306:0:b0:87f:c4bd:8a29])
 (user=joannechien job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:3e12:b0:886:77eb:38fb with SMTP id
 d2e1a72fcca58-897c6e1b5f0mr1132873b3a.25.1791539632394; 
 Fri, 09 Oct 2026 02:53:52 -0700 (PDT)
Date: Fri,  9 Oct 2026 09:53:31 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.170.g584c36229d-goog
Message-ID: <20261009095335.749891-1-joannechien@google.com>
To: Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>
X-Headers-End: 1xF7jB-00061z-V1
Subject: [f2fs-dev] [PATCH v1] f2fs: allow pinning empty compressed files
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
From: Joanne Chang via Linux-f2fs-devel
 <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Joanne Chang <joannechien@google.com>
Cc: Joanne Chang <joannechien@google.com>,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Q29tbWl0IGE2NGEzZmVjMTFlNyAoImYyZnM6IGZvcmNlIG91dC1wbGFjZSB1cGRhdGUgZm9yIGFs
bCB3cml0ZXMgb24KY29tcHJlc3NlZCBmaWxlIikgdXBkYXRlZCBmMmZzX3Nob3VsZF91cGRhdGVf
b3V0cGxhY2UoKSB0byBhbHdheXMKcmV0dXJuIHRydWUgZm9yIGNvbXByZXNzZWQgZmlsZXMuIEhv
d2V2ZXIsIHRoaXMgZnVuY3Rpb24gaXMgYWxzbwpjYWxsZWQgZHVyaW5nIGYyZnNfaW9jX3NldF9w
aW5fZmlsZSgpIHZhbGlkYXRpb24sIHNvIHBpbm5pbmcgYW4KZW1wdHkgZmlsZSB3aXRoIGNvbXBy
ZXNzaW9uIGVuYWJsZWQgbm93IGZhaWxzIHdpdGggLUVJTlZBTCBiZWZvcmUgdGhlCmNvbXByZXNz
aW9uIGZsYWcgY2FuIGJlIHN0cmlwcGVkLgoKRml4IHRoaXMgYnkgZ3VhcmRpbmcgdGhlIGYyZnNf
Y29tcHJlc3NlZF9maWxlKGlub2RlKSBjaGVjayB3aXRoIGZpbyBpbgpmMmZzX3Nob3VsZF91cGRh
dGVfb3V0cGxhY2UoKS4gVGhpcyBwcmVzZXJ2ZXMgZm9yY2VkIE9QVSBmb3IgYWN0dWFsCmNvbXBy
ZXNzZWQgd3JpdGVzIChmaW8gIT0gTlVMTCksIHdoaWxlIGFsbG93aW5nIGYyZnNfaW9jX3NldF9w
aW5fZmlsZSgpCihmaW8gPT0gTlVMTCkgdG8gcHJvY2VlZCB0byBmMmZzX2Rpc2FibGVfY29tcHJl
c3NlZF9maWxlKGlub2RlKS4KCkZpeGVzOiBhNjRhM2ZlYzExZTcgKCJmMmZzOiBmb3JjZSBvdXQt
cGxhY2UgdXBkYXRlIGZvciBhbGwgd3JpdGVzIG9uIGNvbXByZXNzZWQgZmlsZSIpCkFzc2lzdGVk
LWJ5OiBMTE0KU2lnbmVkLW9mZi1ieTogSm9hbm5lIENoYW5nIDxqb2FubmVjaGllbkBnb29nbGUu
Y29tPgotLS0KIGZzL2YyZnMvZGF0YS5jIHwgMiArLQogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0
aW9uKCspLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvZnMvZjJmcy9kYXRhLmMgYi9mcy9m
MmZzL2RhdGEuYwppbmRleCAyNjEzZTg4MjFhZjYuLjFkMDcxZTdjYjFjMiAxMDA2NDQKLS0tIGEv
ZnMvZjJmcy9kYXRhLmMKKysrIGIvZnMvZjJmcy9kYXRhLmMKQEAgLTMxNTAsNyArMzE1MCw3IEBA
IGJvb2wgZjJmc19zaG91bGRfdXBkYXRlX291dHBsYWNlKHN0cnVjdCBpbm9kZSAqaW5vZGUsIHN0
cnVjdCBmMmZzX2lvX2luZm8gKmZpbykKIAkgKiBJZiBJTyBjb21lcyBmcm9tIGNvbXByZXNzZWQg
d3JpdGUgcGF0aCBhbmQgZmFsbGJhY2sgdG8gcmF3IHdyaXRlLAogCSAqIGZvcmNlIG91dOKAkXBs
YWNlIHRvIHByZXZlbnQgbWV0YWRhdGHigJFkYXRhIGluY29uc2lzdGVuY3kuCiAJICovCi0JaWYg
KGYyZnNfY29tcHJlc3NlZF9maWxlKGlub2RlKSkKKwlpZiAoZmlvICYmIGYyZnNfY29tcHJlc3Nl
ZF9maWxlKGlub2RlKSkKIAkJcmV0dXJuIHRydWU7CiAKIAkvKiBzd2FwIGZpbGUgaXMgbWlncmF0
aW5nIGluIGFsaWduZWQgd3JpdGUgbW9kZSAqLwotLSAKMi41Ni4wLjE3MC5nNTg0YzM2MjI5ZC1n
b29nCgoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkxp
bnV4LWYyZnMtZGV2ZWwgbWFpbGluZyBsaXN0CkxpbnV4LWYyZnMtZGV2ZWxAbGlzdHMuc291cmNl
Zm9yZ2UubmV0Cmh0dHBzOi8vbGlzdHMuc291cmNlZm9yZ2UubmV0L2xpc3RzL2xpc3RpbmZvL2xp
bnV4LWYyZnMtZGV2ZWwK
