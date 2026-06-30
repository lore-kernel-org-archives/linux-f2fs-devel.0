Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F910C43458
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 30 Jun 2026 08:51:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:To:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=U46KqEgbWQZJmvVl7WXYh9cTt7RUIvczhg3vzzGcPYU=; b=Px5DhPp5aE/K7Mq4Rr3lHR8cwY
	QAhMaQjCh887nBirfcguK6gvBnYw+38ZRYryqXQxI8w8+5XFuVtx73IZ1bCcYu84RUa6EX7D3ratr
	wOE3aUO3fZKsElw/5Fk3Yw9IdzJ3ND1mlMRIyVtW11fmHvBvLLuSEc4wxXWShZNQqx9g=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1weUBS-00008Q-0B;
	Tue, 30 Jun 2026 08:51:10 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <niuzhiguo84@gmail.com>) id 1weUBR-00008D-1V
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 30 Jun 2026 08:51:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:Cc:To:
 Subject:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=AehExPjBLjjdrvcO2ln8+lYsJvj5DhZE84FQLgzrdmo=; b=k565+pRmjTvgPhcvg5xKDtM//j
 Mm6jFh4XOKTfLvp3QyVe4BEYplSiYYJ0dma/etXl5nDAnpN3Wv4/nwVREZFhVwNNPe+wgoBzL9mwp
 WANOYLk5Iw6Ns4vMycHAFde9W3b8nUWu3pgBHZvS7GirLqW87dlsNDWSUQNltNUkL0ps=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:Cc:To:Subject:Message-ID:Date:From
 :In-Reply-To:References:MIME-Version:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=AehExPjBLjjdrvcO2ln8+lYsJvj5DhZE84FQLgzrdmo=; b=WBrOt/0/5uhyP8Sl6DI3ZY7xFt
 L+mv9TOa4ytkietDw9EZdKOimnv6AHs9aS3vU+mmZzV2bNOXZgyp+SWjX54fi7rDlEh0J6sxRWgOp
 GuiWv6IOlY+5feG8mK/5BED1MUGIfzWqlN6/+howtUncnjhA/fffDW0TvXkRRRUMCenw=;
Received: from mail-wm1-f52.google.com ([209.85.128.52])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1weUBP-0005xD-Ts for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 30 Jun 2026 08:51:09 +0000
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-490791a3e92so1882715e9.0
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 30 Jun 2026 01:51:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782809457; cv=none;
 d=google.com; s=arc-20260327;
 b=o3xTPJfx0c8AMo98ZHZqsoaYE2s+3iox0K1LRjukZVeSrBI4vHlA0aE0pry8lfpTlv
 Y9qS1G3IyaCKIu3OXLAwOCs4LMytkHnAFRLVZatF8QM2CpWlZu/RCLG+E8+dHuiA0Oi7
 /RevCecmDJoxnVvedQGkcfoGG1vRaR1NdFDpDnHIr0/Gvn/akbW/ADf8XisQt59QBmLJ
 w/EQ8t291eDOltAdNuEHMbZyUphjkF+xINvkrulmqPpzLTWXjhJbR3X0mxZQUE+IPEnb
 vZGAu0mR7dLeWn/dwU1KnEzCdOgfMnv/ZeBSjOal4BSFzoaOFsFy6e3bdYdd0gAb7FKT
 kyDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=AehExPjBLjjdrvcO2ln8+lYsJvj5DhZE84FQLgzrdmo=;
 fh=DKifIfT1GYvboWEoucqUZPqz8YDOoj1h/7bIWdMPCRY=;
 b=JUS2qTCPN3zBuh3jZh2ml2Kpm3Hw/Lj9kKcFCIGiRBD2WnT3NDCwoNGZwAjJKEF0Ot
 kLTfrWkIjdnaogid0R3tHLxCEpw2lVxZYZq4pj9mW2AFkr/f+/n8mlV8dTdtS1BbG1SC
 FZOVZgGAgNXj1zYiLZqMctZU4v+RHVB06Y4TgqMtrml3h6nJAVELIh53iLy+5xrZatRd
 8P59IjMiQZVsVekkDSBhN0aB64r6ECoCCAw7exTFhRcCoECn05SkNd8VLpJ7b3hWXbge
 LiCSsowgTybLRsPTQsxzctt7xlx1UK14ChQXTlnLVI2qkfcZF1n+6f42mV+wD3AcAsZC
 g9/w==; darn=lists.sourceforge.net
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782809457; x=1783414257; darn=lists.sourceforge.net;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=AehExPjBLjjdrvcO2ln8+lYsJvj5DhZE84FQLgzrdmo=;
 b=jfEpnD+v8m5vUStd1Y5IdBE2dS9Umw4h/vjBE0HmWt1ShGwDo1caopu7roVy87aDNp
 br6fnQrsjht8VbQ5SEjKnxPN6rLs64D7XJpbD4469CE+2hyUuXoxpcP+7ziaY4hrZyKM
 IM9BqXzWUGfhkBlQ9aNW1eBnXlUcTmC76fSO4eSWMsNKNqT8M8VtcrEniGMsIwUkl7V9
 uqBgFwgWrmk6x4pucSn8u7pOgqmUGw/VOq/XPyKnr1Q4fQX8a5YZutL/oNcuYgCVO/+5
 EcRi3rMgpnloi5WJPCbuCRHkh3EvA9LIlZTXdqf+c2BkC3upEdnIO14b/N+Jb1cSd0u8
 HOVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782809457; x=1783414257;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=AehExPjBLjjdrvcO2ln8+lYsJvj5DhZE84FQLgzrdmo=;
 b=Jk7n/dUjo3jNoTALTPLD0WTwildH7y7h81UCI6AvfSJbZBtabqB/Gih0Y+1Z80RDPn
 F3Aeb4sV8IIJa+fXvkWBLcu1A2buxMCw7LIjpb1w3SGqOGLpjWcPO2Nf4hZgzoUJlBOC
 /yjWT6XrIoEg49vZ0OqKv/cLqejl064oFqLLeeQrS7jNKqdzMpVOM/2yvnH6E2XuvqVY
 yFzoTLA/ApclGzEnyFxYKDqZUA/pu/uTFCAr9SiRm28OgyB3LSnstHTtDmbNUsOf6RFK
 suH+3wGop1lRyYB8VGw4qQBHqD04CynuPp6IXHAKE3r3jmGkYnPuVWH7xYNda3y2lgUt
 CG6A==
X-Forwarded-Encrypted: i=1;
 AFNElJ+R2z69egcCmU7+bAgxY6/Du5HxOp5CGoMwx3YgrLxh9sWZTVAL4TwMFwoDj+ahgyEuqFuhkiPxNrUg2MfsuZjF@lists.sourceforge.net
X-Gm-Message-State: AOJu0YxlJxJDi8y1VQU9sO9T3vwiZB3FwR9SqODF0XT7x7V9Ap9WxyDm
 baWrqeXxHcn4jut4AD5sKegHnXkWLj/LPdag2SbdYWziUsDROKUq26vT4JXyJ1EybZT7MwkVk5v
 RymiUeQkXtER/Mg4IhfF0kIqzJVIG+RM=
X-Gm-Gg: AfdE7ck2s7N69NPhfo+Ti3PVbHOIfzcZIQO5gsjj0KutI4yYfVhw8IO1Z1FFKXOunOD
 vyMuef424iP5Aqsn74pmgWT4V3poxeIpSNSS3BpgpR3maAqJONAETZmjWds1JE6+OyRQSKFmlJn
 1eG4J/5YeUPWp1+Jbd/BvKPXigCQX7eiJUQcfO08lfQ6NY1Qwr/opFvEEvZUekqXE2Iu/XPpHOX
 USuJJki4uolRJOy5qnIlRjtj0IVMIJ90+2ucOfDePEoLppkTY554jRvnIxvG7ftUHPSho95Ug==
X-Received: by 2002:a05:600c:3151:b0:490:b71f:2de with SMTP id
 5b1f17b1804b1-493b82b7c1emr20583365e9.5.1782809456638; Tue, 30 Jun 2026
 01:50:56 -0700 (PDT)
MIME-Version: 1.0
References: <20260629114918.224537-1-chao@kernel.org>
In-Reply-To: <20260629114918.224537-1-chao@kernel.org>
From: Zhiguo Niu <niuzhiguo84@gmail.com>
Date: Tue, 30 Jun 2026 16:50:45 +0800
X-Gm-Features: AVVi8Cfux3wXQbmnlGNQSIONo8xfPWXodmR1aePs77V67gsfPxZOdoHBoE_m8cM
Message-ID: <CAHJ8P3LOBs0gWHM7rT-G51tQ7Q+utn_xupnp2BuBir+cAC-Xiw@mail.gmail.com>
To: Chao Yu <chao@kernel.org>
X-Headers-End: 1weUBP-0005xD-Ts
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix to avoid potential
 section-unaligned pinfile
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
 stable@kernel.org, linux-kernel@vger.kernel.org,
 Daeho Jeong <daehojeong@google.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Q2hhbyBZdSB2aWEgTGludXgtZjJmcy1kZXZlbCA8bGludXgtZjJmcy1kZXZlbEBsaXN0cy5zb3Vy
Y2Vmb3JnZS5uZXQ+CuS6jjIwMjblubQ25pyIMjnml6XlkajkuIAgMTk6NTLlhpnpgZPvvJoKPgo+
IEJsb2NrcyBvZiBwaW5maWxlIG1heSBub3QgYWxpZ25lZCB0byBzZWN0aW9uIHNpemUgZHVlIHRv
IHdyb25nIHVzZQo+IG9uIHBpbmZpbGUsIHJlc3VsdCBpbiBoZWF2eSBvdmVyaGVhZCBvZiBHQywg
bGV0IGF2b2lkIHRoaXMgYnkKPiBhZGRpbmcgYWRkaXRpb25hbCBjaGVjayBjb25kaXRpb24gaW4g
ZjJmc19zZXRhdHRyKCkuCj4KPiAtIHRydW5jYXRlIC1zIDhtYiBwaW5maWxlCj4gOiByYW5kb20g
Y2hlY2twb2ludCBtYXkgcGVyc2lzdCBmaWxlc2l6ZSB3LyBpbm9kZQo+IC0gZmFsbG9jYXRlIC1v
IDAgLWwgOG1iIHBpbmZpbGUKPiAgLSBmMmZzX2ZhbGxvY2F0ZQo+ICAgLSBmMmZzX2V4cGFuZF9p
bm9kZV9kYXRhCj4gICAgLSBmMmZzX2FsbG9jYXRlX3Bpbm5pbmdfc2VjdGlvbgo+ICAgIC0gZjJm
c19tYXBfYmxvY2tzCj4gICAgIC0gZjJmc19tYXBfbG9jawo+ICAgICAtIF9fYWxsb2NhdGVfZGF0
YV9ibG9jawo+ICAgICAtIGZpbGVfbmVlZF90cnVuY2F0ZQo+ICAgICA6IHcvIEZBRFZJU0VfVFJV
TkNfQklULCB3ZSBjYW4gZXhwZWN0IHVuYWxpZ25lZCBtYXBwaW5nIGNhbiBiZQo+ICAgICAgIHRy
dW5jYXRlZCB3aGlsZSBvcGVuKCkgaWYgZjJmcyBpcyBub3QgdW1vdW50IGFibm9ybWFsbHkKPiAg
ICAgLSBmMmZzX21hcF91bmxvY2sKPiAgICAgOiBmb2xsb3dpbmcgZjJmcyBjaGVja3BvaW50IGFu
ZCBzdWRkZW4gcG93ZXItY3V0Cj4KPiAtIG1vdW50Cj4gLSBvcGVuIHBpbmZpbGUKPiAgLSBmMmZz
X2ZpbGVfb3Blbgo+ICAgLSBmaW5pc2hfcHJlYWxsb2NhdGVfYmxvY2tzCj4gICAgLSB0cnVuY2F0
ZV9zZXRzaXplCj4gICAgOiBmaWxlc2l6ZSBpcyA4bWIKPiAgICAtIGYyZnNfdHJ1bmNhdGUKPiAg
ICA6IGNhbiBvbmx5IHRydW5jYXRlIGJsb2NrIG91dHNpZGUgZmlsZXNpemUsIHJhdGhlciB0aGFu
IHRydW5jYXRpbmcKPiAgICAgIHVuYWxpZ25lZCBibG9ja3MgaW5zaWRlIGZpbGVzaXplCkhpIENo
YW8sCjhNQiBpcyBzZWN0aW9uIGFsaW5nZWQgd2hlbiBmYWxsb2NhdGVkIGJ5IGYyZnNfYWxsb2Nh
dGVfcGlubmluZ19zZWN0aW9uPz8Kc28gSG93IGNvdWxkIHRoZXJlIGFyZSB1bmFsaWduZWQgYmxv
Y2tzIGluc2lkZSBmaWxlc2l6ZT8KPgo+IEZpeGVzOiBmNWE1M2VkY2YwMWUgKCJmMmZzOiBzdXBw
b3J0IGFsaWduZWQgcGlubmVkIGZpbGUiKQo+IENjOiBzdGFibGVAa2VybmVsLm9yZwo+IENjOiBE
YWVobyBKZW9uZyA8ZGFlaG9qZW9uZ0Bnb29nbGUuY29tPgo+IFNpZ25lZC1vZmYtYnk6IENoYW8g
WXUgPGNoYW9Aa2VybmVsLm9yZz4KPiAtLS0KPiAgZnMvZjJmcy9maWxlLmMgfCAyOCArKysrKysr
KysrKysrKysrKy0tLS0tLS0tLS0tCj4gIDEgZmlsZSBjaGFuZ2VkLCAxNyBpbnNlcnRpb25zKCsp
LCAxMSBkZWxldGlvbnMoLSkKPgo+IGRpZmYgLS1naXQgYS9mcy9mMmZzL2ZpbGUuYyBiL2ZzL2Yy
ZnMvZmlsZS5jCj4gaW5kZXggZjRmYWNkNDA5ZDliLi4xMWNjOGQ3OWMyMzUgMTAwNjQ0Cj4gLS0t
IGEvZnMvZjJmcy9maWxlLmMKPiArKysgYi9mcy9mMmZzL2ZpbGUuYwo+IEBAIC0xMTA3LDE3ICsx
MTA3LDIzIEBAIGludCBmMmZzX3NldGF0dHIoc3RydWN0IG1udF9pZG1hcCAqaWRtYXAsIHN0cnVj
dCBkZW50cnkgKmRlbnRyeSwKPiAgICAgICAgICAgICAgICAgICAgICAgICAhSVNfQUxJR05FRChh
dHRyLT5pYV9zaXplLAo+ICAgICAgICAgICAgICAgICAgICAgICAgIEYyRlNfQkxLX1RPX0JZVEVT
KGZpLT5pX2NsdXN0ZXJfc2l6ZSkpKQo+ICAgICAgICAgICAgICAgICAgICAgICAgIHJldHVybiAt
RUlOVkFMOwo+IC0gICAgICAgICAgICAgICAvKgo+IC0gICAgICAgICAgICAgICAgKiBUbyBwcmV2
ZW50IHNjYXR0ZXJlZCBwaW4gYmxvY2sgZ2VuZXJhdGlvbiwgd2UgZG9uJ3QgYWxsb3cKPiAtICAg
ICAgICAgICAgICAgICogc21hbGxlci9lcXVhbCBzaXplIHVuYWxpZ25lZCB0cnVuY2F0aW9uIGZv
ciBwaW5uZWQgZmlsZS4KPiAtICAgICAgICAgICAgICAgICogV2Ugb25seSBzdXBwb3J0IG92ZXJ3
cml0ZSBJTyB0byBwaW5uZWQgZmlsZSwgc28gZG9uJ3QKPiAtICAgICAgICAgICAgICAgICogY2Fy
ZSBhYm91dCBsYXJnZXIgc2l6ZSB0cnVuY2F0aW9uLgo+IC0gICAgICAgICAgICAgICAgKi8KPiAt
ICAgICAgICAgICAgICAgaWYgKGYyZnNfaXNfcGlubmVkX2ZpbGUoaW5vZGUpICYmCj4gLSAgICAg
ICAgICAgICAgICAgICAgICAgYXR0ci0+aWFfc2l6ZSA8PSBpX3NpemVfcmVhZChpbm9kZSkgJiYK
PiAtICAgICAgICAgICAgICAgICAgICAgICAhSVNfQUxJR05FRChhdHRyLT5pYV9zaXplLAo+IC0g
ICAgICAgICAgICAgICAgICAgICAgIEYyRlNfQkxLX1RPX0JZVEVTKENBUF9CTEtTX1BFUl9TRUMo
c2JpKSkpKQo+IC0gICAgICAgICAgICAgICAgICAgICAgIHJldHVybiAtRUlOVkFMOwo+ICsKPiAr
ICAgICAgICAgICAgICAgaWYgKGYyZnNfaXNfcGlubmVkX2ZpbGUoaW5vZGUpKSB7Cj4gKyAgICAg
ICAgICAgICAgICAgICAgICAgLyoKPiArICAgICAgICAgICAgICAgICAgICAgICAgKiBJdCBtYXkg
YnJlYWsgc2VjdGlvbi1hbGlnbmVkIGZhbGxvY2F0ZSByZWNvdmVyeQo+ICsgICAgICAgICAgICAg
ICAgICAgICAgICAqIG1lY2hhbmlzbSwgc28gZG8gbm90IGFsbG93IGxhcmdlciBzaXplIHRydW5j
YXRpb24uCj4gKyAgICAgICAgICAgICAgICAgICAgICAgICovCj4gKyAgICAgICAgICAgICAgICAg
ICAgICAgaWYgKGF0dHItPmlhX3NpemUgPiBpX3NpemVfcmVhZChpbm9kZSkpCj4gKyAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICByZXR1cm4gLUVJTlZBTDsKSXMgaXQgb2sgaWYgd2UgYWxs
b3cgbGFyZ2VyIHNpemUgdHJ1bmNhdGlvbiBhbmQgYWxzbyAgbGltaXQgaXQgdG8KYWxpZ25lZCAi
RjJGU19CTEtfVE9fQllURVMoQ0FQX0JMS1NfUEVSX1NFQyhzYmkpIj8KdGhhbmtzIQo+ICsgICAg
ICAgICAgICAgICAgICAgICAgIC8qCj4gKyAgICAgICAgICAgICAgICAgICAgICAgICogVG8gcHJl
dmVudCBzY2F0dGVyZWQgcGluIGJsb2NrIGdlbmVyYXRpb24sIHdlIGRvbid0Cj4gKyAgICAgICAg
ICAgICAgICAgICAgICAgICogYWxsb3cgc21hbGxlci9lcXVhbCBzaXplIHVuYWxpZ25lZCB0cnVu
Y2F0aW9uIGZvcgo+ICsgICAgICAgICAgICAgICAgICAgICAgICAqIHBpbm5lZCBmaWxlLgo+ICsg
ICAgICAgICAgICAgICAgICAgICAgICAqLwo+ICsgICAgICAgICAgICAgICAgICAgICAgIGVsc2Ug
aWYgKCFJU19BTElHTkVEKGF0dHItPmlhX3NpemUsCj4gKyAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICBGMkZTX0JMS19UT19CWVRFUyhDQVBfQkxLU19QRVJfU0VDKHNiaSkpKSkKPiArICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIHJldHVybiAtRUlOVkFMOwo+ICsgICAgICAgICAg
ICAgICB9Cj4gICAgICAgICB9Cj4KPiAgICAgICAgIGlmIChpc19xdW90YV9tb2RpZmljYXRpb24o
aWRtYXAsIGlub2RlLCBhdHRyKSkgewo+IC0tCj4gMi40OS4wCj4KPgo+Cj4gX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KPiBMaW51eC1mMmZzLWRldmVsIG1h
aWxpbmcgbGlzdAo+IExpbnV4LWYyZnMtZGV2ZWxAbGlzdHMuc291cmNlZm9yZ2UubmV0Cj4gaHR0
cHM6Ly9saXN0cy5zb3VyY2Vmb3JnZS5uZXQvbGlzdHMvbGlzdGluZm8vbGludXgtZjJmcy1kZXZl
bAoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkxpbnV4
LWYyZnMtZGV2ZWwgbWFpbGluZyBsaXN0CkxpbnV4LWYyZnMtZGV2ZWxAbGlzdHMuc291cmNlZm9y
Z2UubmV0Cmh0dHBzOi8vbGlzdHMuc291cmNlZm9yZ2UubmV0L2xpc3RzL2xpc3RpbmZvL2xpbnV4
LWYyZnMtZGV2ZWwK
