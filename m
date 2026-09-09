Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4E87C79FB6
	for <linux-f2fs-devel@archiver.kernel.org>; Wed,  9 Sep 2026 18:44:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:To:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=iwaICIzJcjXlFXlMlpkcoKcgRBMOEyWtuix9BdnbtZc=; b=mZo1lFDjhMPEiarqGO2T5xvPr9
	U+q970AnhGcm/I6kaR/Qt70+e74rGSGygfvyq1FxuPrReNZE6sfpyjFRKm0+U8U845PJLWrlKHFEp
	iUNxL1/ywrvzpbKo3U3NDt0vAhQU7q3s4G8HSgMM+FZd5KTOhFwDrz70dhvVVV7O86Ec=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1x4NHj-0002cs-OM;
	Wed, 09 Sep 2026 18:44:40 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <daeho43@gmail.com>) id 1x4NHd-0002cj-Ji
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 09 Sep 2026 18:44:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:Cc:To:
 Subject:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=DDlK8Hcn9GGpXziSrv5Y5Bf+KxxDJlvMEGPxYg6Eges=; b=HRGkQMUeEccLG9S0zoCfV/lCq/
 YGb/ahFdIHFbY9P5gV7buq2hKYWpL2SCiY+Aw5yfLogYBmhRT1kB7EcdvAXRbxQgQWSkyQarVC53I
 rzU0F+bQBOOOtYisP8ofdSdMuwClRsRrtaxifyiacfc8zeYqTKyvrX3D8/frTkgRsh68=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:Cc:To:Subject:Message-ID:Date:From
 :In-Reply-To:References:MIME-Version:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=DDlK8Hcn9GGpXziSrv5Y5Bf+KxxDJlvMEGPxYg6Eges=; b=Nq2tCm8qptB3GbQJAu2Lr2szja
 1SfqHSrGTl+/4kVoeDpBF3hVHSeLzBh6tVmqvBkhL/OscPPRKOZ0fIAwHfUJ4c/H36ZTyiFVIY43O
 9TJG6qagkpXPTFkSM4CHy0kPtWtP9o2hC9pslV+YB5ihO0cRdLZbFWSRVkyvWDWb2XV8=;
Received: from mail-lf2-f12.google.com ([74.125.229.204])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x4NHb-0004Kp-QU for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 09 Sep 2026 18:44:34 +0000
Received: by mail-lf2-f12.google.com with SMTP id
 2adb3069b0e04-5b74e0c2e4dso770953e87.0
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed, 09 Sep 2026 11:44:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788979465; cv=none;
 d=google.com; s=arc-20260327;
 b=PRK8kyVpIuyP9P0rQ8WIFukuEkjQibdNJRKjBm4DxSfUYbTDyrxWvsf90VyEwbymTJ
 VFh3jqESHDYL186bA72VPZeIhReU+kTw8CQqXEnHwNdi+MdDx9P5Aqt6cXRXv7T1UlxQ
 YF9YUz4nm6rvfYYR2qWG4tLEEsuCnJys8BSyhqeM6g76XSrelP079xGiWv+Vb9G3QOUP
 V4o5qtZwTNzZZXy1k9IGeUzQnHvspqt9Cdr39tXur+MMN2Bro6lQxIEAxhgr1pfoDhKS
 p0Q5UMBouoAGoN78Yqo6lSjkd2vbJ9kaPaHv3i15zfqt5k7uSBtae3yAs4o4FuH5VrqG
 3ugw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=DDlK8Hcn9GGpXziSrv5Y5Bf+KxxDJlvMEGPxYg6Eges=;
 fh=fPlMUkxmqp4UlGW+upfITeOSWsISEtfOhwzLHJT5e2w=;
 b=oy/aS00ktdfz645ngP9lcBV75Ry3QFiYgTLlRb13X/XpLwatSkmaKhfYTZUR4QG/uH
 /b+s9qA+rYUz1w74Do30Dw++svpjkI570hbsLqxsIgQLqgxBTGcsj5rdDmXdfcTyMqbD
 abQ0JRLGmvcTmeRrFXaiE5rzh7tphUzNqhlrVs4D99F3l6ZYhwoyQZYq/aQZXEFsPIfo
 dqj7jkYqlX9jS5SLKBAAVpNPnpCUmQE8A42K6bOImRbUc9CkQzDh83vt/i6WxaObQ/TX
 3yEBU2fBUpt4w1x7JqPRJGBs9pHZhGdqkowszudt/+PYIPWVyj19mLfYUcRB+Y5qJXRp
 DLtA==; darn=lists.sourceforge.net
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788979465; x=1789584265; darn=lists.sourceforge.net;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=DDlK8Hcn9GGpXziSrv5Y5Bf+KxxDJlvMEGPxYg6Eges=;
 b=ic9kbGnX8rfdDLEyPMjS8EhqmzHKWZjjCfIl2OqSxSJrjF6HTSzOGlEAzauyGx5+n7
 t9ZiKPGrC/0Cn4YC2FNZmgJLVXYbIomZLTD/04cPQcRgEMfPIzwY+ECiRJgwAJViTNdO
 Y+v6En6fB5VPj3ISRaTZbi3hvsaX0EZwZtC8De6oFpnvY7/IK3pdBdOUk3ds/jKt2onr
 RTpkTqia3tPXkqEg9jBikphB65j2jhW22CljvGjgcTIqBhOCjkL06IFEHPx8ejIxgD3F
 PmPALlOQ5QNRnJ9mcud/zEa694eaK3qN/0nLlfdZmxE4hsPVHR0fqNoyS1qOCz/HNHMc
 /nwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788979465; x=1789584265;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=DDlK8Hcn9GGpXziSrv5Y5Bf+KxxDJlvMEGPxYg6Eges=;
 b=FdSnmgEuWX91InszF3BaOCOk4mrbtjF35Az7iI07KnA5ebzMKkF9oppLo8DnCh0OmR
 8mbmwF/mEUpf0of8whD4ILOn5O5E4AxmWSq+8mUNnNAhoSPob6Ckmy6IWR0PxnUCOx0F
 1nHFxjNnDddpYUG4Zui7hvEO6dzaZ6TtEggOVbBTYbaGB3xUWYhYmF1zkBdSPRHJIMM0
 IrT7o5Zp+kgh1NmWd9PbFRbyuiuko6vt/veI7QpoYPbj0j68KUgPOsRhtwV0UD3f98iw
 NYPos2A3mHEPPvjmu5bmLAPFcwAN3948DDFaA2DsbKKv76EQh5PNQIPJmSjO+qTJX1GX
 2X3Q==
X-Forwarded-Encrypted: i=1;
 AKwUvBw5mtlgO7NREFybMGVt9sNFgvarwKyQ6ISzssSDxMX5YNbza3RAVtRvHr484HQS/y6FYM0x9ut5YHPCr2cJkjxI@lists.sourceforge.net
X-Gm-Message-State: AFuF++nNx4DcZOR7lWPEn1+NrCMJ3c+ih70EFRClEMawz2Te+oK62+D4
 QFDZ/qbHhZzQpTtkHJVknmTzZMITAbut0tlq0pV0a7KJ6F3Kb1RJAee7txyv4FMK1L+unf1NL+f
 oU4yBKdHYs/74H2264FRSrnBEDmqGczEoPskC
X-Gm-Gg: AYBFou3A2TGiBn4Rl91SvuxzMU9MPtdmzT8YUdWe5872iZTlATz5E8B8VvsDQjl/R0G
 oUmli86sxwAHDcgFHh3NNg4fVSPyMVjYmnJZcTSF7TmEWJgyxakYOtSUAXL2uALTeZ/4IOvZG62
 x2SazS9uxvFmlMamPLlrRgtPvDI1fULwW8VTxyucW91xSaJcc0ZYaj/gz51jXXiASKcfE4ThUrB
 zX4aL981d59hpnxHqqyw/3A0IMUF44o037Qf3IoM5Qdz3tbWxxeujsKwEDrqGkkRU4feE2VBycr
 eLlnB9MPmU77v0FZbgtAYjlokkjNuhKNygMa1np+tYg53YfGMpY+jZgytJfUHr+70qBWCf93Tuy
 /J4V5Qe9nBbK5bmyO+0spfPsqQyhESQndHf1qbEV6JOa2
X-Received: by 2002:a05:6512:3c8f:b0:5b4:4c28:2249 with SMTP id
 2adb3069b0e04-5b8988e910emr981843e87.24.1788979464739; Wed, 09 Sep 2026
 11:44:24 -0700 (PDT)
MIME-Version: 1.0
References: <20260904145923.1936598-1-daeho43@gmail.com>
 <90c7fbe0-3f06-48a1-a9df-6b9ae6a3d9d1@kernel.org>
In-Reply-To: <90c7fbe0-3f06-48a1-a9df-6b9ae6a3d9d1@kernel.org>
From: Daeho Jeong <daeho43@gmail.com>
Date: Wed, 9 Sep 2026 11:44:12 -0700
X-Gm-Features: AcwNN1WKiOH5Uc6PiJElHi-TeunKAfxK32KwaDjqsWz5qFfHiuKoawksEE8GEBA
Message-ID: <CACOAw_wQvkwAZP1d9KkgmZx3Jkt8F-iOrRKoD+XNEyWDhyj8nA@mail.gmail.com>
To: Chao Yu <chao@kernel.org>
X-Headers-End: 1x4NHb-0004Kp-QU
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix livelock in f2fs_sync_inode_meta()
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
Cc: Daeho Jeong <daehojeong@google.com>, kernel-team@android.com,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

T24gTW9uLCBTZXAgNywgMjAyNiBhdCAzOjIz4oCvQU0gQ2hhbyBZdSA8Y2hhb0BrZXJuZWwub3Jn
PiB3cm90ZToKPgo+IE9uIDkvNC8yNiAyMjo1OSwgRGFlaG8gSmVvbmcgd3JvdGU6Cj4gPiBGcm9t
OiBEYWVobyBKZW9uZyA8ZGFlaG9qZW9uZ0Bnb29nbGUuY29tPgo+ID4KPiA+IER1cmluZyBjaGVj
a3BvaW50LCBmMmZzX3N5bmNfaW5vZGVfbWV0YSgpIGl0ZXJhdGVzIG92ZXIgZGlydHkgaW5vZGVz
IGluCj4gPiB0aGUgRElSVFlfTUVUQSBsaXN0LiBJZiBpZ3JhYigpIGZhaWxzIG9uIGFuIGlub2Rl
IChlLmcuIGJlY2F1c2UgaXQgaXMgaW4KPiA+IHRoZSBmcmVlaW5nIHN0YXRlKSwgdGhlIGxvb3Ag
Y29udGludWVzIHdpdGhvdXQgbW92aW5nIHRoZSBjdXJyZW50IGlub2RlIHRvCj4gPiB0aGUgdGFp
bCBvZiB0aGUgbGlzdC4gQXMgYSByZXN1bHQsIHN1YnNlcXVlbnQgaXRlcmF0aW9ucyBwaWNrIHRo
ZSBzYW1lCj4gPiBpbm9kZSByZXBlYXRlZGx5LCBwcmV2ZW50aW5nIG90aGVyIHJlYWR5IGRpcnR5
IGlub2RlcyBpbiB0aGUgbGlzdCBmcm9tCj4gPiBtYWtpbmcgZm9yd2FyZCBwcm9ncmVzcyBhbmQg
bGVhZGluZyB0byBhIGxpdmVsb2NrLgo+ID4KPiA+IEZpeCB0aGlzIGJ5IG1vdmluZyB0aGUgY3Vy
cmVudCBpbm9kZSB0byB0aGUgdGFpbCBvZiB0aGUgbGlzdAo+ID4gKGxpc3RfbW92ZV90YWlsKCZm
aS0+Z2RpcnR5X2xpc3QsIGhlYWQpKSBiZWZvcmUgYXR0ZW1wdGluZyBpZ3JhYigpLgo+ID4KPiA+
IEFkZGl0aW9uYWxseSwgaWYgaWdyYWIoKSBmYWlscywgdGhlIGZyZWVpbmcgaW5vZGUgbWF5IGJl
IHdhaXRpbmcgZm9yIGl0cwo+ID4gcGVuZGluZyB3cml0ZWJhY2sgZGF0YSBwYWdlcyB0byBjb21w
bGV0ZSBkdXJpbmcgZXZpY3Rpb24uCj4gPiBTdWJtaXQgYW55IHBlbmRpbmcgbWVyZ2VkIGRhdGEg
d3JpdGVzIGFuZCB5aWVsZCB0aGUKPiA+IENQVSB3aXRoIGNvbmRfcmVzY2hlZCgpIHRvIGFsbG93
IHRoZSBldmljdGlvbiB0byBtYWtlIHByb2dyZXNzLgo+ID4KPiA+IFNpZ25lZC1vZmYtYnk6IERh
ZWhvIEplb25nIDxkYWVob2plb25nQGdvb2dsZS5jb20+Cj4gPiAtLS0KPiA+ICAgZnMvZjJmcy9j
aGVja3BvaW50LmMgfCA4ICsrKysrKysrCj4gPiAgIDEgZmlsZSBjaGFuZ2VkLCA4IGluc2VydGlv
bnMoKykKPiA+Cj4gPiBkaWZmIC0tZ2l0IGEvZnMvZjJmcy9jaGVja3BvaW50LmMgYi9mcy9mMmZz
L2NoZWNrcG9pbnQuYwo+ID4gaW5kZXggZWYyMjY5MmNlZjBhLi41NTk3MDMzNTMzYjAgMTAwNjQ0
Cj4gPiAtLS0gYS9mcy9mMmZzL2NoZWNrcG9pbnQuYwo+ID4gKysrIGIvZnMvZjJmcy9jaGVja3Bv
aW50LmMKPiA+IEBAIC0xNDYwLDYgKzE0NjAsNyBAQCBzdGF0aWMgaW50IGYyZnNfc3luY19pbm9k
ZV9tZXRhKHN0cnVjdCBmMmZzX3NiX2luZm8gKnNiaSkKPiA+ICAgICAgICAgICAgICAgfQo+ID4g
ICAgICAgICAgICAgICBmaSA9IGxpc3RfZmlyc3RfZW50cnkoaGVhZCwgc3RydWN0IGYyZnNfaW5v
ZGVfaW5mbywKPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIGdkaXJ0eV9saXN0KTsKPiA+ICsgICAgICAgICAgICAgbGlzdF9tb3ZlX3RhaWwo
JmZpLT5nZGlydHlfbGlzdCwgaGVhZCk7Cj4KPiBTZWVtcyBmaW5lLCBpZiBzbywgZG8gd2UgbmVl
ZCB0byBkbyB0aGlzIGluIGYyZnNfc3luY19kaXJ0eV9pbm9kZXMoKSBhcyB3ZWxsPwo+Cj4gPiAg
ICAgICAgICAgICAgIGlub2RlID0gaWdyYWIoJmZpLT52ZnNfaW5vZGUpOwo+ID4gICAgICAgICAg
ICAgICBzcGluX3VubG9jaygmc2JpLT5pbm9kZV9sb2NrW0RJUlRZX01FVEFdKTsKPiA+ICAgICAg
ICAgICAgICAgaWYgKGlub2RlKSB7Cj4gPiBAQCAtMTQ2OSw2ICsxNDcwLDEzIEBAIHN0YXRpYyBp
bnQgZjJmc19zeW5jX2lub2RlX21ldGEoc3RydWN0IGYyZnNfc2JfaW5mbyAqc2JpKQo+ID4gICAg
ICAgICAgICAgICAgICAgICAgIGlmIChpc19pbm9kZV9mbGFnX3NldChpbm9kZSwgRklfRElSVFlf
SU5PREUpKQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgZjJmc191cGRhdGVfaW5v
ZGVfcGFnZShpbm9kZSk7Cj4gPiAgICAgICAgICAgICAgICAgICAgICAgaXB1dChpbm9kZSk7Cj4g
PiArICAgICAgICAgICAgIH0gZWxzZSB7Cj4gPiArICAgICAgICAgICAgICAgICAgICAgLyoKPiA+
ICsgICAgICAgICAgICAgICAgICAgICAgKiBXZSBzaG91bGQgc3VibWl0IGJpbywgc2luY2UgaXQg
ZXhpc3RzIHNldmVyYWwKPiA+ICsgICAgICAgICAgICAgICAgICAgICAgKiB3cml0ZWJhY2tpbmcg
cGFnZXMgaW4gdGhlIGZyZWVpbmcgaW5vZGUuCj4gPiArICAgICAgICAgICAgICAgICAgICAgICov
Cj4gPiArICAgICAgICAgICAgICAgICAgICAgZjJmc19zdWJtaXRfbWVyZ2VkX3dyaXRlKHNiaSwg
REFUQSk7Cj4gPiArICAgICAgICAgICAgICAgICAgICAgY29uZF9yZXNjaGVkKCk7Cj4KPiBJdCB1
c2VzIHRoZSBzYW1lIGltcGxlbWVudGF0aW9uIGZyb20gZjJmc19zeW5jX2RpcnR5X2lub2Rlcygp
LCBhZnRlciBnaXQgYmxhbWUgb24KPiBpdCwgdGhlIGltcGxlbWVudGF0aW9uIHdhcyBpbnRyb2R1
Y2UgbG9uZyB0aW1lIGFnbywgSSBzdXNwZWN0IHdlIGRvbid0IG5lZWQgdGhpcz8KPiBiZWNhdXNl
IGluIC53cml0ZXBhZ2VzLCB3ZSB3aWxsIHN1Ym1pdCBjYWNoZWQgYmlvIGFueXdheSwgcmlnaHQ/
Cj4KPiBUaGFua3MsCgoKVGhhbmtzIGZvciB0aGUgcmV2aWV3LgoKMS4gUmVnYXJkaW5nIGxpc3Rf
bW92ZV90YWlsIGluIGYyZnNfc3luY19kaXJ0eV9pbm9kZXMoKToKSSB3aWxsIGFwcGx5IGxpc3Rf
bW92ZV90YWlsKCkgdG8gZjJmc19zeW5jX2RpcnR5X2lub2RlcygpIGFzIHdlbGwgaW4gdjIuCgoy
LiBSZWdhcmRpbmcgZjJmc19zdWJtaXRfbWVyZ2VkX3dyaXRlKHNiaSwgREFUQSk6ClRoZSBvcmln
aW5hbCBpbnRlbnRpb24gd2FzIGp1c3QgYSBkZWZlbnNpdmUgbWVhc3VyZSBpbiBjYXNlIHRoZSBm
cmVlaW5nIGlub2RlCndhcyB3YWl0aW5nIGluIGYyZnNfZXZpY3RfaW5vZGUoKSAtPiBmaWxlbWFw
X2ZkYXRhd2FpdCgpIGZvciB3cml0ZWJhY2sKY29tcGxldGlvbi4KSSB3aWxsIHJlbW92ZSBmMmZz
X3N1Ym1pdF9tZXJnZWRfd3JpdGUoc2JpLCBEQVRBKSBhbmQga2VlcCBvbmx5IGNvbmRfcmVzY2hl
ZCgpCmluIHRoZSBlbHNlIGJsb2NrLCBhbmQgdXBkYXRlIGJvdGggZjJmc19zeW5jX2lub2RlX21l
dGEoKSBhbmQKZjJmc19zeW5jX2RpcnR5X2lub2RlcygpIGluIHYyLgoKVGhhbmtzLApEYWVobwoK
Pgo+ID4gICAgICAgICAgICAgICB9Cj4gPiAgICAgICB9Cj4gPiAgICAgICByZXR1cm4gMDsKPgoK
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkxpbnV4LWYy
ZnMtZGV2ZWwgbWFpbGluZyBsaXN0CkxpbnV4LWYyZnMtZGV2ZWxAbGlzdHMuc291cmNlZm9yZ2Uu
bmV0Cmh0dHBzOi8vbGlzdHMuc291cmNlZm9yZ2UubmV0L2xpc3RzL2xpc3RpbmZvL2xpbnV4LWYy
ZnMtZGV2ZWwK
