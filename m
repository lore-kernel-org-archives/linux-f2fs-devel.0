Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4C10C79FA1
	for <linux-f2fs-devel@archiver.kernel.org>; Wed,  9 Sep 2026 01:13:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:To:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gx/UWdS8svrq7ln2XxvyrAoy8fNcnHGaIR2Xaxqz4/8=; b=VRRcLBQc3hG7kHxUoX9XnpaKOh
	gaDBO/wSETQWks3vF2c7lNOLfMT6D7V6+CPfUCa7NJu7ZhWDcwR/S76zwja3R7zJvbz/KaGAZnmZb
	bwZG26uMdvcRRhH6ciFUJqWlNcYCvbe8fd9Z/SyjNbg7ApZ/mSWVtdwnUmY3tjV1MyXQ=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1x46sA-0005Wp-3k;
	Wed, 09 Sep 2026 01:13:10 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <niuzhiguo84@gmail.com>) id 1x46s8-0005Wg-6Z
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 09 Sep 2026 01:13:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:Cc:To:
 Subject:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Q/pbXnjBJcdoF7CaGTuOgdcdmxNeEQ1orWGBuh7m6GU=; b=bQm/fyg1vXKUZiwIB+OMbfuEp6
 M0fDZDqyXsjy/pLyVgHRaaf498MfFUqOC1QBSEIspI3JBMM7WQZDZJgVvgCrMc/TviMocJYqtP7ha
 f2R/Xr2+FKBfQBcg8nalbGzgTfKsCf+5p8M2WPBN/hhPaWsISjhlW7kJC8a4G0+pkSrc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:Cc:To:Subject:Message-ID:Date:From
 :In-Reply-To:References:MIME-Version:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=Q/pbXnjBJcdoF7CaGTuOgdcdmxNeEQ1orWGBuh7m6GU=; b=W1G+OqU7qNFglx6pnx0uMG3n/6
 QHDdnf8KnTaW5+T59XsEJ85m3yCZvgAJ7biVYnyIITuyBGx1X69Y76VBjWeEWJQnb26dEFrkiM5no
 sxMEzxiXf/tJ2Xjrmfeb68e2ipSn0Yu6p13TcrhpDarU4P0OQ3cVmykx7JFlqA4OywNY=;
Received: from mail-wr2-f12.google.com ([74.125.225.76])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x46s6-0008Ve-RI for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 09 Sep 2026 01:13:08 +0000
Received: by mail-wr2-f12.google.com with SMTP id
 ffacd0b85a97d-4838dbf1bbeso468077f8f.0
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 08 Sep 2026 18:13:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788916380; cv=none;
 d=google.com; s=arc-20260327;
 b=Ipw/Awjpz28C1v2NBJGx+jBN0hf+EEMyyAW9gz4JgocDoGIPZaKFxZ90pqV+DMUyn6
 EEtzkmg28iTtYtHD2YxeMtQ4EsIHJLVWrgotlqtwApTdoBzQwC8+LPB7/5eCJw6icJxw
 s0N42+iw/F2JNj72SRwizH9nQiLo32RYOMs4n35BQtuMUpSIHF3J+e6NT8ltiy1mk6Ax
 MfsfIrJ788KoxdfaQCJkC8kxTt6CqJjfdzQBXVeVV610EKDRCkS3rrVWFA3RqocOt5Nf
 64yG3x/H7PZBaprd3sp/0oVmg3iOAeg8UGm00J2Eww5JNShpzbLQ5uk6Kl+FOfaP3kd9
 19UA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Q/pbXnjBJcdoF7CaGTuOgdcdmxNeEQ1orWGBuh7m6GU=;
 fh=bPhnA6B6AR3AylFVCFlr6VaJVkHl1Q5pHO4YG9est0Y=;
 b=TtuB63BoKKPpWRCIAqxDjRBuUwnEEL+VV7og8dBvbHe48qGIm0lsSXx5e4elicCkzD
 /N62ry02VEJ+TnFsLx+CR1kVNm3BDXCSlqRqN3viukyFMmJgD+ZVIysVHnrxSQbWaUf5
 zRFzwBDqoHAZzJJ2BMUt3niQr7L2ge4cU80IchG2sH9C9H8ohcBl8Wf30ezfqPvdgf3s
 Wt6ftGZBrrCfNsUvcgl8lOEcthXqe485RchLEh6c0M0qz3J+XbbsSYhNflbCgw/MIp4u
 jmcxTm6hdfReSqb3CoTfiTquBE4YEASfQa3h5WNa97pi3uSOK9OOfzFgeGzDalJSOCVL
 DDsw==; darn=lists.sourceforge.net
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788916380; x=1789521180; darn=lists.sourceforge.net;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Q/pbXnjBJcdoF7CaGTuOgdcdmxNeEQ1orWGBuh7m6GU=;
 b=RvCiV2OgWo/RHWqkXiDdJL6NgtYeOPAm0fqOT8FxN833dHyWMFeR+OqtdmxJHi10FX
 4tzxr13xCstD3qqA9pT30Fx1uvRsRqzz6OFjQdsD7sgLLqwtV+JBCZwCjCaovHd90TER
 /dB07RLBfriEbI7UdzWESoiJxaum8k36iDPUAhfXIfMXZLy/YpVnS5aGPiaTC8spGVg4
 A8dx8Po69i0wOvdgreZf0u2oSowe1/1TZP2IUdpefLizH10vPO2oYlpDDSVUyI49+eJW
 BdIZrCNpZkPFfippFeJ0qN39B90dimabOQSMfOIOgDzytV16OQmyWK6ylnnE4W6scCwa
 uWGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788916380; x=1789521180;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Q/pbXnjBJcdoF7CaGTuOgdcdmxNeEQ1orWGBuh7m6GU=;
 b=pvm/1Y56iTnA8roBhkpBJVGcfYWzGFOLYZRPSCKTSPsHtuaMDgJcxohbC/s4aEZSgd
 fGqMFauLNHKRCf8CuEMINlnCgK0oVerLUssbTwzOLZKEM0dsHBzUvSMq4gdAbx+OPOC4
 b4QDtVdk3+OcfRsWZnpeEBaQyFLBoXtybL354cSwBxdYc6iVQQrhDRn+AYPJi9cUqknC
 F4oVoo3m4v8w+8OGBK979nKJP7JGeLVKbisvRl3KSozUuw8GiikcXEkRdbEdda1UZpAJ
 i8nVCLP6SjgCyIBP5HOEYwuJxYNrUU8oVWaRiQijhjbG/UQ1/gWByZLfTbVh9+kV6px6
 F5iA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwTKXoQ5eTjQVmFNIIyP2NnMUoxQkFaMehxG/fz1gU8EwV8Ruj9Nf5GM1+XbIgSpgSp5o8ENk1W9Xi6prcOnRi0@lists.sourceforge.net
X-Gm-Message-State: AFuF++lvwg2gjqBVD3cKytQAcBPAlqldkXvAfoW0uEi8ocPCZVRCCKMq
 OtWgjLTqt66m8zrVRjdFQakIhjN6xO+RkschiLPqBFf+n1Dq38UeLgcd2n9lxq4LpV8efy1OC2m
 +NUIHC8tVXqHLkq9XymTL4m8ZZbommKg=
X-Gm-Gg: AYBFou3suTgfZUGpMwmQoTWKd9YY7Au8s3o6S9cnc60j6vF8Eoj7opgv5V5Zt5muDSx
 zOPaLA85KXcZZVqJcLV3FBRtTmAaOxmm0DcO0LwDjPWr4vDSAuA/SUNMg+fCtREE+duWlj5dhHf
 ON7TQ8K8Se3Y+9zkA2d5xBwVD7ZpMwooM1qFkD4AudPZ5vyB/x9fiSx00PxzuP+Dk3XgCUcNnzb
 UP2JsabWw9em+5DYgrZ7h6IeJOpZ/5+9L3cv+h+/xFaROImAB0P9thmnY8nCgILGkL+rkgPRDsM
 Y2ShWKENmutTb2GD4Yo9rVB1smzuoEf5p5P62x7Kj9y2DWJdrMV9Qlx4
X-Received: by 2002:a05:6000:144e:b0:485:8d31:ccf9 with SMTP id
 ffacd0b85a97d-485907ef7a6mr22363733f8f.4.1788916380195; Tue, 08 Sep 2026
 18:13:00 -0700 (PDT)
MIME-Version: 1.0
References: <20260824131729.3694378-1-chao@kernel.org>
In-Reply-To: <20260824131729.3694378-1-chao@kernel.org>
From: Zhiguo Niu <niuzhiguo84@gmail.com>
Date: Wed, 9 Sep 2026 09:12:48 +0800
X-Gm-Features: AcwNN1Vcn3h2XagHNWBx2qCvHznDVYzJaDWMaestGz_GrOmdGRLa4VxE9UXUXkg
Message-ID: <CAHJ8P3+KBs1cQnDPsfpHOyjxNA+JNQ5DPCbrF_JqTLcmoyzB1w@mail.gmail.com>
To: Chao Yu <chao@kernel.org>
X-Headers-End: 1x46s6-0008Ve-RI
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix to avoid potential deadloop in
 f2fs_fsync_node_pages()
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
 stable@kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Q2hhbyBZdSB2aWEgTGludXgtZjJmcy1kZXZlbCA8bGludXgtZjJmcy1kZXZlbEBsaXN0cy5zb3Vy
Y2Vmb3JnZS5uZXQ+CuS6jjIwMjblubQ45pyIMjTml6XlkajkuIAgMjE6MTnlhpnpgZPvvJoKPgo+
IFRoZXJlIGlzIHBvdGVudGlhbCBkZWFkbG9vcCBpbiByYWNlIGNvbmRpdGlvbjoKPgo+IFRocmVh
ZCBBICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBUaHJlYWQgQgo+IC0gZnN5bmMKPiAg
LSBmMmZzX2RvX3N5bmNfZmlsZQo+ICAgLSBmMmZzX2ZzeW5jX25vZGVfcGFnZXMKPiAgICAtIGxh
c3RfZnN5bmNfZG5vZGUKPiAgICAgLSBmb2xpb19nZXQobGFzdF9mb2xpbykKPiAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgLSBmMmZzX3NldGF0dHIKPiAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIC0gZjJmc190cnVuY2F0ZQo+ICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIC0gZjJmc190cnVuY2F0ZV9ibG9ja3MK
PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgLSBmMmZzX2RvX3Ry
dW5jYXRlX2Jsb2Nrcwo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgLSBmMmZzX3RydW5jYXRlX2lub2RlX2Jsb2Nrcwo+ICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIC0gdHJ1bmNhdGVfZG5vZGUKPiAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgLSB0cnVuY2F0ZV9ub2RlCj4gICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAtIGludmFsaWRhdGVfbWFwcGlu
Z19wYWdlcwo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IC0gZm9saW8tPm1hcHBpbmcgPSBOVUxMCj4gICAgLSBpc19ub2RlX2ZvbGlvIGFsd2FzeSByZXR1
cm4gZmFsc2UKPiAgICAtIGF0b21pYyAmJiAhbWFya2VkIGlzIGFsd2F5cyB0cnVlLAo+ICAgICAg
dGhlbiBnb3RvIHJldHJ5Cj4KPiBDYzogc3RhYmxlQGtlcm5lbC5vcmcKPiBGaXhlczogNjA4NTE0
ZGViYTM4ICgiZjJmczogc2V0IGZzeW5jIG1hcmsgb25seSBmb3IgdGhlIGxhc3QgZG5vZGUiKQo+
IFNpZ25lZC1vZmYtYnk6IENoYW8gWXUgPGNoYW9Aa2VybmVsLm9yZz4KPiAtLS0KPiAgZnMvZjJm
cy9ub2RlLmMgfCA1ICsrKysrCj4gIDEgZmlsZSBjaGFuZ2VkLCA1IGluc2VydGlvbnMoKykKPgo+
IGRpZmYgLS1naXQgYS9mcy9mMmZzL25vZGUuYyBiL2ZzL2YyZnMvbm9kZS5jCj4gaW5kZXggOTY4
ZTVlZDM4ODE2Li44NmMyZTY3ZTQzYjYgMTAwNjQ0Cj4gLS0tIGEvZnMvZjJmcy9ub2RlLmMKPiAr
KysgYi9mcy9mMmZzL25vZGUuYwo+IEBAIC0yMDE2LDYgKzIwMTYsMTEgQEAgaW50IGYyZnNfZnN5
bmNfbm9kZV9wYWdlcyhzdHJ1Y3QgZjJmc19zYl9pbmZvICpzYmksIHN0cnVjdCBpbm9kZSAqaW5v
ZGUsCj4gICAgICAgICAgICAgICAgIGYyZnNfZGVidWcoc2JpLCAiUmV0cnkgdG8gd3JpdGUgZnN5
bmMgbWFyazogaW5vPSV1LCBpZHg9JWx4IiwKPiAgICAgICAgICAgICAgICAgICAgICAgICAgICBp
bm8sIGxhc3RfZm9saW8tPmluZGV4KTsKPiAgICAgICAgICAgICAgICAgZm9saW9fbG9jayhsYXN0
X2ZvbGlvKTsKPiArICAgICAgICAgICAgICAgaWYgKHVubGlrZWx5KCFpc19ub2RlX2ZvbGlvKGxh
c3RfZm9saW8pKSkgewpIaSBDaGFvLAppc19ub2RlX2ZvbGlvLT5OT0RFX01BUFBJTkcoRjJGU19G
X1NCKGZvbGlvKSktPkYyRlNfTV9TQihmb2xpby0+bWFwcHBpbmcpLT5GMkZTX0lfU0IobWFwcGlu
Zy0+aG9zdCkKaWYgbWFwcGluZz09TlVMTCwgcGFuaWMgd2lsbCBvY2N1ciBoZXJlPwpqdXN0IGxp
a2UgIGNvbW1pdCBtc2cgaW4gIG1haTogImYyZnM6IHBhcmFtZXRlcml6ZSBub2RlIGhlbHBlcnMg
YW5kIG1hY3JvcyIKdGhhbmtz77yBCgo+ICsgICAgICAgICAgICAgICAgICAgICAgIGYyZnNfZm9s
aW9fcHV0KGxhc3RfZm9saW8sIHRydWUpOwo+ICsgICAgICAgICAgICAgICAgICAgICAgIHJldCA9
IC1FQUdBSU47Cj4gKyAgICAgICAgICAgICAgICAgICAgICAgZ290byBvdXQ7Cj4gKyAgICAgICAg
ICAgICAgIH0KPiAgICAgICAgICAgICAgICAgZjJmc19mb2xpb193YWl0X3dyaXRlYmFjayhsYXN0
X2ZvbGlvLCBOT0RFLCB0cnVlLCB0cnVlKTsKPiAgICAgICAgICAgICAgICAgZm9saW9fbWFya19k
aXJ0eShsYXN0X2ZvbGlvKTsKPiAgICAgICAgICAgICAgICAgZm9saW9fdW5sb2NrKGxhc3RfZm9s
aW8pOwo+IC0tCj4gMi40OS4wCj4KPgo+Cj4gX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KPiBMaW51eC1mMmZzLWRldmVsIG1haWxpbmcgbGlzdAo+IExpbnV4
LWYyZnMtZGV2ZWxAbGlzdHMuc291cmNlZm9yZ2UubmV0Cj4gaHR0cHM6Ly9saXN0cy5zb3VyY2Vm
b3JnZS5uZXQvbGlzdHMvbGlzdGluZm8vbGludXgtZjJmcy1kZXZlbAoKCl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkxpbnV4LWYyZnMtZGV2ZWwgbWFpbGlu
ZyBsaXN0CkxpbnV4LWYyZnMtZGV2ZWxAbGlzdHMuc291cmNlZm9yZ2UubmV0Cmh0dHBzOi8vbGlz
dHMuc291cmNlZm9yZ2UubmV0L2xpc3RzL2xpc3RpbmZvL2xpbnV4LWYyZnMtZGV2ZWwK
