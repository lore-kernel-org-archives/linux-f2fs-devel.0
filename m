Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 974C5C5CFDB
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 14 Aug 2026 15:32:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:To:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ZtXlHtWBbZ8Od1L4/8dPgGy4F3IhL/iRMQtcrHMqn0w=; b=Zu/ILQ3jhFupaWE1dLnU1j+F5T
	vrVJGUuZcVvE/5b3/9RR3VLnUS5jtEnOL6vltkVBlNDtFgm1EuR0+LxODRu2aouNDD87sFVzGaLhB
	morFPHqrifpGuCJjQeEum0k216/q+ig33Go0d5pAmP67dWX/6jAGynDC2pMavCYvrhDI=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wutti-0005nc-Nk;
	Fri, 14 Aug 2026 15:32:42 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <daeho43@gmail.com>) id 1wutti-0005nV-6E
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 14 Aug 2026 15:32:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:Cc:To:
 Subject:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=TK7PQvHRhfO7d69vCikmlkkwgXEXe3Jt7PiHxltn8vg=; b=Rqwy88RthbI6MK5ZNz84MMn6j6
 LmBlcYYaS8rqVvAWivIcITATaRrCfDT5DP39nVflGjmZlOZ3vyMz9txXxJmNh7SX261H4rm4rTAoq
 1CiX9TuiTZiW8YQOGCdQWUxJzpkNCq21ycDGKKi3yh0Y+iOVyKf7rNWaxtI7J9mBLRbc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:Cc:To:Subject:Message-ID:Date:From
 :In-Reply-To:References:MIME-Version:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=TK7PQvHRhfO7d69vCikmlkkwgXEXe3Jt7PiHxltn8vg=; b=XzFRqplus30Ut14NV/HurWEcZY
 KEgkvcybRo1WoWcvQYsLAtmcdwICQEogd8UhA/yrxVVRR7plB/BqvIS2tElFnYIuXA5C5XPAFyfVh
 kK5XP57iD1/sjUN10MGlO9tBPOeK01K28gEphkaWU7Epwgl5K9ZrU6VISiToWHxptKNQ=;
Received: from mail-lf1-f50.google.com ([209.85.167.50])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wuttg-00050w-Ff for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 14 Aug 2026 15:32:42 +0000
Received: by mail-lf1-f50.google.com with SMTP id
 2adb3069b0e04-5aeb59d54b1so1182069e87.1
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri, 14 Aug 2026 08:32:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786721553; cv=none;
 d=google.com; s=arc-20260327;
 b=dYDJ6i/He2T4RVGUUF/dGDwF94klap9NpMcQO9ZvlQYPrZ4TABIzom8NHlyhrABNPa
 4slgpLAL7VSxfNZhBQP/Ygb/X+tcmrXkgdirOZ6cSWB9hy+DhB1ylN6UWIPq9ka+gzJh
 +mUOKfv79iHrrtiekcIE4W4JWeIIxvOSg4JppsqSYZ87PGBFUUSsY0CI0pEDYFuKglcO
 It5scikfFN+LRduo4W5/a4DOM8PrN0E3B8tF1ownVzuKPNfl6rpVx3Z0p2JzuuZ0Bdux
 nHJDxEAvaGMhNyg7t6p0eD1pq+168WHXmI+Kg6kPsIE3hCuFnT/q67odO/UbDghZe2XV
 BOhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=TK7PQvHRhfO7d69vCikmlkkwgXEXe3Jt7PiHxltn8vg=;
 fh=kv6YURhOY6DWydvGU55cbyrcAoi3+Shoo3mADYe0Kcw=;
 b=QsA2lynFfYhn2h3EO7uUTOw4YqM0Zqs89fxwyJF+oNkwRW9OlskCa9lC0gay23wENB
 f/gC87KKvCrjbSOgNay91ij528cyiF+wqC5YSnPq8ngF3Y6vK/sO1iPBecp4U4jIhA0v
 7sTNjV0kc+DZhX9rcIWcvl9O838OYxjx3rqaRj9Vla3yhljQEz4S8JzfJuZCKm/FZu3P
 PvwWHVZEdr6LsafALa7QZt1nFm3/c4Rd2z9jk9GZO81Gi3xezzF267t1u4avCxbyFmxn
 gduhq/7ZBy7mGTTeiJsuJqBm+HFiUWpvxTEsvc+ZNp8uzbywmw+kdZklQFIwIugxGBTE
 z2qQ==; darn=lists.sourceforge.net
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786721553; x=1787326353; darn=lists.sourceforge.net;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=TK7PQvHRhfO7d69vCikmlkkwgXEXe3Jt7PiHxltn8vg=;
 b=ksjufw+kJBuHxkq3NZq7iCQXy3qyFmkiMYBAPY8J/sHSxorXxm2ibqBp824bzwfPkB
 A6tvREgQbXSHaVnuMy0g6kSxZGLM+m/wxeB3sZH1uN/s/+gp4Qjm/imbpLCFNM0bbRHM
 TWhk1XSqkhN0Lkpz3wemLQWu+ZGuamk0tFylmtn3rbxns3ZLY1JUMwPDKb1gMbreSpWZ
 pmHPAPHTqvFxj8Wp72Mbwd+UVW1KrjfT7GdoCJSSe73tZAdkyjUxLEsma6r0pA5CFbP1
 4+/EmxuWJSqBRMSuTCqE78AXovO8qMcN9JQ0xPLqsR6+C6Emow6LVaCPCpOibMDfLvbj
 Dk4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786721553; x=1787326353;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=TK7PQvHRhfO7d69vCikmlkkwgXEXe3Jt7PiHxltn8vg=;
 b=F8qEW9bHjpLjY9PJRfScuU+B3bzoGIWkobdgFxHp/ylBuoayIMz/Ze3fuwo7VmojJZ
 DcY4sg2iy6hz31VP+K9HbO5/NBlc4yaKTdoiautKeUtsS/1SFXVDtPhGsupmA/8IoXJ4
 6ELjy402BkEc52EReSA6/hNK7mDvJ95nLtfX/qO7/Ok00lKBC24Wz925lz7gi9tdUCEx
 +QEzoGtlGYfaGqVJ0RC0+4XTSM8Q9ZBq1qtKeK/u7R4XtZgh69dKi3t8zHuoq3VpWN2Y
 G4TAaL+Cp8gAYVhx9viRRLqj11DjYPYlgrP4PKClogL+qB93Ee5q7obh5XPoX2RKLCSk
 1Yow==
X-Forwarded-Encrypted: i=1;
 AHgh+RqxfiCigWYWCPqHhDq5j7Dl8HNy11d5JDBMfW76mzHN8CaczsdNBJVBtxLhlXTE4nm+QYl9DbnHq56S/wgBRG/8@lists.sourceforge.net
X-Gm-Message-State: AOJu0YzYuaU4OWKS/Q0/YU1FWPgSrOY19pEB4F1qAIeKHOJifgOeYq2e
 +VgCJ3+C1jDC4YE9XDDrn+Ug/SVgtPQDrmzh++Mim6vfZoma/Pwnirvdo079cx7ltyhzEGBZFNs
 5I8gcyOtkCELT2rOt4NVPo8TGv/IgUfE=
X-Gm-Gg: AR+sD13CZ0sryR6tgowkbhcfamq+eBGFQXcWJBRA3Pl/MqcnaGEV5nfXBYruwj/9tk3
 +OXq30fPDR8Ie2OMtnROY4s7gQ4/0xMS05eVAyYYbB8fEjawwtE3J9CIlW5C3k5x/Ys+kYMEc+l
 QnAgevcxeGTh/7gOT8lV4eLZZzmbR94/GHx7JZ/5qSlAYOQkELgVbTWwEBPMfqLxsE3GOPSEXsg
 mRM3/238LwNkRlZ7sbQ9OCPixNwYS3icAxP/EE3FfrFNG26ozQHH3atrpmIS/eOo/NZCMa0UpeT
 iOPAn3VlCGjaS9johiW5b9vopAvRxapu/AeCs8hagYHQ9FPZNP+dogxTocixM1wbCxaWSphkY7F
 x1rjRaYCEJPWK/6JW7qfJPw4Zf+3qOyWS/A==
X-Received: by 2002:a05:6512:3b11:b0:5ae:bbe5:2076 with SMTP id
 2adb3069b0e04-5b45914ab46mr1037748e87.52.1786721552817; Fri, 14 Aug 2026
 08:32:32 -0700 (PDT)
MIME-Version: 1.0
References: <20260806170108.2100312-1-daeho43@gmail.com>
 <ann0OPPglToV_hjs@infradead.org>
 <ff74edb1-43c7-485f-ab78-ec13b500a0bb@acm.org>
 <CACOAw_zqOS0vHdQV6WoUJyxnDf=kdDAz27pNGDLdQLUdUYOzBQ@mail.gmail.com>
 <an62BorNrc-IX228@infradead.org>
In-Reply-To: <an62BorNrc-IX228@infradead.org>
From: Daeho Jeong <daeho43@gmail.com>
Date: Fri, 14 Aug 2026 08:32:20 -0700
X-Gm-Features: AUfX_mx2Pto06m45d7F2_lptjs17kW4x65ZWOP5JIP6wMXsiPjstrC3FI6rq2kA
Message-ID: <CACOAw_zKnj-o_7OhEWcVGYeFy6m1GM1KCW3hhgBX+O=KTev1jQ@mail.gmail.com>
To: Christoph Hellwig <hch@infradead.org>
X-Headers-End: 1wuttg-00050w-Ff
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: quiesce background threads during
 system suspend using PM notifier
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
Cc: Pavel Machek <pavel@kernel.org>, Daeho Jeong <daehojeong@google.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 Len Brown <lenb@kernel.org>, kernel-team@android.com,
 Bart Van Assche <bvanassche@acm.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

T24gVGh1LCBBdWcgMTMsIDIwMjYgYXQgMTE6MzDigK9QTSBDaHJpc3RvcGggSGVsbHdpZyA8aGNo
QGluZnJhZGVhZC5vcmc+IHdyb3RlOgo+Cj4gT24gTW9uLCBBdWcgMTAsIDIwMjYgYXQgMDk6NTM6
MTRBTSAtMDcwMCwgRGFlaG8gSmVvbmcgd3JvdGU6Cj4gPiBPbiBNb24sIEF1ZyAxMCwgMjAyNiBh
dCA5OjM04oCvQU0gQmFydCBWYW4gQXNzY2hlIDxidmFuYXNzY2hlQGFjbS5vcmc+IHdyb3RlOgo+
ID4gPiBUaGlzIGluZm9ybWF0aW9uIHdhcyBzaGFyZWQgZWFybGllciB3aXRoIERhZWhvCj4gPiA+
IChodHRwczovL2IuY29ycC5nb29nbGUuY29tL2lzc3Vlcy81MTU0NzAzMDkjY29tbWVudDQ1KTog
WyAuLi4gXQo+Cj4gVGhpcyBkb2VzIG5vdCBzZWVtIHRvIGJlIGluZm9ybWF0aW9uIGF2YWlsYWJs
ZSB0byB0aGUgcHVibGljLgo+Cj4gPiBmMmZzIHRocmVhZHMgYXJlIGFscmVhZHkgZnJlZXphYmxl
OiBmMmZzX2djIGFuZCBmMmZzX2Rpc2NhcmQgYXJlCj4gPiBhbHJlYWR5IHJlZ2lzdGVyZWQgd2l0
aCBzZXRfZnJlZXphYmxlKCkgYW5kIGNhbGwgdHJ5X3RvX2ZyZWV6ZSgpLgo+ID4gSG93ZXZlciwg
YSByYWNlIHdpbmRvdyBleGlzdHM6IGEgdGhyZWFkIGNoZWNrcyBmcmVlemluZygpIChmYWxzZSks
Cj4gPiBjYWxscyBzdWJtaXRfYmlvKCksIGFuZCBnZXRzIHRyYXBwZWQgaW5zaWRlIF9fYmlvX3F1
ZXVlX2VudGVyKCkuCj4gPiBCZWNhdXNlIGl0IGdldHMgYmxvY2tlZCBiZWZvcmUgcmVhY2hpbmcg
dHJ5X3RvX2ZyZWV6ZSgpLCBpdCB0cmlnZ2VycyBhCj4gPiBQTSBmcmVlemVyIHRpbWVvdXQuCj4K
PiBUaGlzIGRvZXMgc291bmQgdmVyeSBtdWNoIGxpa2UgYSBibG9jayBsYXllciBmcmVlemluZyBp
c3N1ZS4KPgo+ID4gUG9pbnQgdGFrZW4uIEFzaWRlIGZyb20gdGhpcyBmMmZzIHBhdGNoLCBJIGFn
cmVlIHRoYXQgYWRkcmVzc2luZyB0aGlzCj4gPiBhdCB0aGUgYmxvY2sgbGF5ZXIgb3IgUE0gc3Vi
c3lzdGVtIGxldmVsIHdvdWxkIGJlIGEgbXVjaCBjbGVhbmVyLAo+ID4gc3lzdGVtLXdpZGUgc29s
dXRpb24uCj4gPiBJ4oCZbGwgZ2l2ZSBtb3JlIHRob3VnaHQgdG8gaG93IHdlIGNhbiBwcm9wZXJs
eSBzb2x2ZSB0aGlzIHJhY2UKPiA+IGNvbmRpdGlvbiBmb3IgdGhlIGVudGlyZSBzeXN0ZW0sIGFu
ZCBJJ2xsIGxvb3AgaW4gdGhlIHJlbGV2YW50Cj4gPiBQTS9ibG9jayBtYWludGFpbmVycyBpZiBh
IHZpYWJsZSBnZW5lcmljIGFwcHJvYWNoIGVtZXJnZXMuCj4KPiBUaGFua3MsIGl0IHdvdWxkIGJl
IGdyZWF0IHRvIGZpeCB0aGlzIHByb3Blcmx5LgoKTm93LCBJIGFtIGNvbnNpZGVyaW5nIG1vZGlm
eWluZyBibG9jay9ibGstY29yZS5jIHRvIGludHJvZHVjZQpmcmVlemVyLWF3YXJlIGVycm9yIGhh
bmRsaW5nIGluIF9fYmlvX3F1ZXVlX2VudGVyKCkuCgpUaGUgaWRlYSBpcyB0byBoYXZlIF9fYmlv
X3F1ZXVlX2VudGVyKCkgY2hlY2sgd2hldGhlciB0YXNrIGZyZWV6aW5nIGlzCmFjdGl2ZSBiZWZv
cmUgaXQgZGVjaWRlcyB0byBibG9jayBvbiBtcV9mcmVlemVfd3EuCgpJZiB0aGUgc3lzdGVtIGlz
IGluIHRoZSBwcm9jZXNzIG9mIGZyZWV6aW5nLCBpdCB3b3VsZCBpbW1lZGlhdGVseQpyZXR1cm4g
YW4gZXJyb3IgaW5zdGVhZCBvZiB3YWl0aW5nIGluZGVmaW5pdGVseSBvbiBhIGZyb3plbiBwbV93
cS4KCkkgd291bGQgZ3JlYXRseSBhcHByZWNpYXRlIHlvdXIgdGhvdWdodHMgb24gdGhpcyBhcHBy
b2FjaC4KClRoYW5rIHlvdSBpbiBhZHZhbmNlIGZvciB5b3VyIHRpbWUgYW5kIGluc2lnaHRzLgoK
PgoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkxpbnV4
LWYyZnMtZGV2ZWwgbWFpbGluZyBsaXN0CkxpbnV4LWYyZnMtZGV2ZWxAbGlzdHMuc291cmNlZm9y
Z2UubmV0Cmh0dHBzOi8vbGlzdHMuc291cmNlZm9yZ2UubmV0L2xpc3RzL2xpc3RpbmZvL2xpbnV4
LWYyZnMtZGV2ZWwK
