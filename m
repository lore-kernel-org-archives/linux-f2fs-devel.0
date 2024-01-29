Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16EC6C47DDB
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 29 Jan 2024 16:19:53 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1rUUMQ-0000if-Jj;
	Mon, 29 Jan 2024 16:19:51 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <daeho43@gmail.com>) id 1rUUMP-0000iZ-57
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 29 Jan 2024 16:19:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:Cc:To:
 Subject:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=sxIMPwXxO56Te04nQLiHnEy/gVhT8AAzuKsrBhH07uY=; b=eNF9oafmFQ0cqNq7kQrB7vnfYq
 OChRSeg+H2Uzu4TocFkOeHMJLGTssvcdvMje7OeAFcEA3tqWL01Ou9tajyintJQpwJd4TFsuabHmJ
 ZXmp/i7898uSElkW7ZVoOuLqtvHb69TX+t/Em3ak2MUS9422hE6IMZbNHelzS707u7tI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:Cc:To:Subject:Message-ID:Date:From
 :In-Reply-To:References:MIME-Version:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=sxIMPwXxO56Te04nQLiHnEy/gVhT8AAzuKsrBhH07uY=; b=XoIXfna9wAIn2mG+9sQBpk1MBM
 /Vi8X/eZrslvcTzBVAjB+WhrpHIZne865Ci9BIGspNUqRih4OsRP0t+guHO5JraLtEEmhZ7NxdHCQ
 As65Lu2HIWF3W2Ma1Jg8bNYmvf3pgSBt0ihxfh5WLtbUZTNsSv4YvKXNPhgvGC2tMELI=;
Received: from mail-vk1-f173.google.com ([209.85.221.173])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1rUUMO-0002sg-RH for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 29 Jan 2024 16:19:50 +0000
Received: by mail-vk1-f173.google.com with SMTP id
 71dfb90a1353d-4bd2e945a35so371386e0c.2
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 29 Jan 2024 08:19:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1706545178; x=1707149978; darn=lists.sourceforge.net;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sxIMPwXxO56Te04nQLiHnEy/gVhT8AAzuKsrBhH07uY=;
 b=YHLOYAbJxisUcEePQvxJlkj8bzl2tmWJIdAf34rsrfo6Ge8eFHlUKOVYfNxho701mP
 hIdOHcqBdzFcM/ERO1OctGSiJqjaVFeqjZfXPfLrSJcRfhlG3S9a8mAeCgNq+EnATiGt
 blgUpkhSrtGvI+LtP9fxt1uJWVXMCkVTV0voi+oZ5MZOpTj4jDzOY/8ADn9ZUMX7sFaY
 DAzSxNE6KhFBhKxziRjFnjm7tK89lSOPJ54Y3LFoNUUIciRUpW256itZETPGVlbLX4y8
 PWqycRC1gHU4VJ/aRJMRffwxTNc+oNAhZuw02G+jC39nWF0zvsoanxnQqOhCJIr+CxsC
 EEFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706545178; x=1707149978;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sxIMPwXxO56Te04nQLiHnEy/gVhT8AAzuKsrBhH07uY=;
 b=af9brNl0cDHZKF7CD4cWEoUqSNNCDg8Evq62jIV3+sBHRXYn7qQiHqNefXLrKCYlEj
 hlI0vV2W/IUuvpr+q5XYibJlabKSA8kzgBif0VCK+GrLR5DU+y7TKiu74JrHT38AOszu
 qqvmdc4bn5ayikOmW0AHzdZZb0/OWhV+B0H4hAGNVn3/NYMeqAixZsXwjIbfOOP4CJiA
 fNF44HtQwx99FlHIqbPgJFojkKnQA+2HdOV1sHg7QwLYBQex/X2NjoG8JMCJB4PPiZ0j
 LXg6c0AUv5VIbsEfRQsQZYBx8fH3mfeo3CPjqBCOgUytWUUNoWU2y1iyv20NAjmnPOoi
 tMXQ==
X-Gm-Message-State: AOJu0YzhWzHirPtGTKBDAtTCDNCoE/mJuV+s0hibZm4KHLJC8gmZcxOy
 0GZ4donfTqUzcWdJrnKpwrChbhmuffnhrjcviubD9eXyffU0vG5f9r4tSAivey+/0E/wNIbEdeD
 2Mz25b9V+ub7fv4E3yMHti0A3MQ4=
X-Google-Smtp-Source: AGHT+IEqDtuEvINWYbcnE6QTCFFMC/ThpAq5Z34OgSGGbN/aqboub29Gbf+ovelQfmc0eCJ+Gb7SsYN5uHCFvArPFJU=
X-Received: by 2002:a05:6122:1793:b0:4bd:8b9c:d551 with SMTP id
 o19-20020a056122179300b004bd8b9cd551mr2471464vkf.18.1706545178178; Mon, 29
 Jan 2024 08:19:38 -0800 (PST)
MIME-Version: 1.0
References: <20240129112740.1908649-1-chao@kernel.org>
In-Reply-To: <20240129112740.1908649-1-chao@kernel.org>
From: Daeho Jeong <daeho43@gmail.com>
Date: Mon, 29 Jan 2024 08:19:27 -0800
Message-ID: <CACOAw_w=GsdGyLZN8ZWZ=G7ogo_oRqLXaBCqzVwHkqXT=pxNnA@mail.gmail.com>
To: Chao Yu <chao@kernel.org>
X-Headers-End: 1rUUMO-0002sg-RH
Subject: Re: [f2fs-dev] [PATCH] f2fs: zone: fix to wait completion of last
 bio in zone correctly
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
Cc: jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 Daeho Jeong <daehojeong@google.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

UmV2aWV3ZWQtYnk6IERhZWhvIEplb25nIDxkYWVob2plb25nQGdvb2dsZS5jb20+CgpUaGFua3Ms
CgpPbiBNb24sIEphbiAyOSwgMjAyNCBhdCAzOjI54oCvQU0gQ2hhbyBZdSA8Y2hhb0BrZXJuZWwu
b3JnPiB3cm90ZToKPgo+IEl0IG5lZWRzIHRvIGNoZWNrIGxhc3Qgem9uZV9wZW5kaW5nX2JpbyBh
bmQgd2FpdCBJTyBjb21wbGV0aW9uIGJlZm9yZQo+IHRyYXZlcnNlIG5leHQgZmlvIGluIGlvLT5p
b19saXN0LCBvdGhlcndpc2UsIGJpbyBpbiBuZXh0IHpvbmUgbWF5IGJlCj4gc3VibWl0dGVkIGJl
Zm9yZSBhbGwgSU8gY29tcGxldGlvbiBpbiBjdXJyZW50IHpvbmUuCj4KPiBGaXhlczogZTA2N2Rj
M2M2YjljICgiZjJmczogbWFpbnRhaW4gc2l4IG9wZW4gem9uZXMgZm9yIHpvbmVkIGRldmljZXMi
KQo+IENjOiBEYWVobyBKZW9uZyA8ZGFlaG9qZW9uZ0Bnb29nbGUuY29tPgo+IFNpZ25lZC1vZmYt
Ynk6IENoYW8gWXUgPGNoYW9Aa2VybmVsLm9yZz4KPiAtLS0KPiAgZnMvZjJmcy9kYXRhLmMgfCAz
ICstLQo+ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDIgZGVsZXRpb25zKC0pCj4K
PiBkaWZmIC0tZ2l0IGEvZnMvZjJmcy9kYXRhLmMgYi9mcy9mMmZzL2RhdGEuYwo+IGluZGV4IGY0
NWVjYjgxMGFlNi4uOGNkYmM1YWU0NGRiIDEwMDY0NAo+IC0tLSBhL2ZzL2YyZnMvZGF0YS5jCj4g
KysrIGIvZnMvZjJmcy9kYXRhLmMKPiBAQCAtMTAwNiw3ICsxMDA2LDcgQEAgdm9pZCBmMmZzX3N1
Ym1pdF9wYWdlX3dyaXRlKHN0cnVjdCBmMmZzX2lvX2luZm8gKmZpbykKPiAgICAgICAgIGYyZnNf
YnVnX29uKHNiaSwgaXNfcmVhZF9pbyhmaW8tPm9wKSk7Cj4KPiAgICAgICAgIGYyZnNfZG93bl93
cml0ZSgmaW8tPmlvX3J3c2VtKTsKPiAtCj4gK25leHQ6Cj4gICNpZmRlZiBDT05GSUdfQkxLX0RF
Vl9aT05FRAo+ICAgICAgICAgaWYgKGYyZnNfc2JfaGFzX2Jsa3pvbmVkKHNiaSkgJiYgYnR5cGUg
PCBNRVRBICYmIGlvLT56b25lX3BlbmRpbmdfYmlvKSB7Cj4gICAgICAgICAgICAgICAgIHdhaXRf
Zm9yX2NvbXBsZXRpb25faW8oJmlvLT56b25lX3dhaXQpOwo+IEBAIC0xMDE2LDcgKzEwMTYsNiBA
QCB2b2lkIGYyZnNfc3VibWl0X3BhZ2Vfd3JpdGUoc3RydWN0IGYyZnNfaW9faW5mbyAqZmlvKQo+
ICAgICAgICAgfQo+ICAjZW5kaWYKPgo+IC1uZXh0Ogo+ICAgICAgICAgaWYgKGZpby0+aW5fbGlz
dCkgewo+ICAgICAgICAgICAgICAgICBzcGluX2xvY2soJmlvLT5pb19sb2NrKTsKPiAgICAgICAg
ICAgICAgICAgaWYgKGxpc3RfZW1wdHkoJmlvLT5pb19saXN0KSkgewo+IC0tCj4gMi40MC4xCj4K
Pgo+Cj4gX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KPiBM
aW51eC1mMmZzLWRldmVsIG1haWxpbmcgbGlzdAo+IExpbnV4LWYyZnMtZGV2ZWxAbGlzdHMuc291
cmNlZm9yZ2UubmV0Cj4gaHR0cHM6Ly9saXN0cy5zb3VyY2Vmb3JnZS5uZXQvbGlzdHMvbGlzdGlu
Zm8vbGludXgtZjJmcy1kZXZlbAoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fCkxpbnV4LWYyZnMtZGV2ZWwgbWFpbGluZyBsaXN0CkxpbnV4LWYyZnMtZGV2
ZWxAbGlzdHMuc291cmNlZm9yZ2UubmV0Cmh0dHBzOi8vbGlzdHMuc291cmNlZm9yZ2UubmV0L2xp
c3RzL2xpc3RpbmZvL2xpbnV4LWYyZnMtZGV2ZWwK
