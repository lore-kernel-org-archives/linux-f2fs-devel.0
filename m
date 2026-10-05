Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DF51CA5FF5
	for <linux-f2fs-devel@archiver.kernel.org>; Mon,  5 Oct 2026 20:17:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:Date:To:From:Sender:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=yrPE5S9bCQG6jkwhBs33a56mfK+9Sfa/Prtlc4wvkn4=; b=cSNtuUsfdLoRHnn3UBTnjLFZhq
	I6TSUXbtu1h3oT8rlWgJEdqLeeaCe0y0KmkhFaza3Pvv2OLBCMaFs241to6xI8TKkapRse9wtws2r
	InjNE+4vVbizG3w//TUabDochuvFfdgGsOE4XHsfOSEv7TKZuRqUxXpj96fUuGruitMs=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xDp7p-0005Ii-MB;
	Mon, 05 Oct 2026 20:17:27 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <qkrwngud825@gmail.com>) id 1xDp7o-0005Ib-Rn
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 05 Oct 2026 20:17:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:MIME-Version
 :Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Zj1GsVK6MEWmNxZ1LapynJJcv+KBUbleHw06Rt4t2Gg=; b=DRB2tvX/GkoZL2EumFZLFyZ6ie
 FlN23lMgMQoPfD3OD8RqiRaEkvx2bM1wpUjT/9qI/PDBEW00oYXmgZj69x8Yh+WQq0ibTpJO536pO
 MpfwZARuWgOJdpkQKESRxUoA7XizCMVIprVPtpHnnVWn+lakvpy3jVU19HjLEpcfKzWs=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:
 Subject:Cc:To:From:Sender:Reply-To:Content-ID:Content-Description:Resent-Date
 :Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=Zj1GsVK6MEWmNxZ1LapynJJcv+KBUbleHw06Rt4t2Gg=; b=C
 ZwIk0weikSd81duxAlKQCpc3u6c9nxvZjZ487ZXGIOQEW5qPfV2e0T1sRk2a6c3D5I9kGVRfHAee2
 S1zR5OgML+sLSEoivhrOJDmKO8HAoyU9Hm0KMLsClxnLbVGOhQqeHrR2IceZmqnXoTmQOebbn8BUH
 zx2K1SOZ97+T3rmo=;
Received: from mail-pz2-f42.google.com ([74.125.228.42])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xDp7k-00010y-Vx for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 05 Oct 2026 20:17:26 +0000
Received: by mail-pz2-f42.google.com with SMTP id
 41be03b00d2f7-cc1cea4bfd1so614382a12.0
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 05 Oct 2026 13:17:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791231439; x=1791836239; darn=lists.sourceforge.net;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=Zj1GsVK6MEWmNxZ1LapynJJcv+KBUbleHw06Rt4t2Gg=;
 b=lFX3a32AFNC9ImDqFnndEy9LdexOHWGk6dxjYnjzhNx2jlVrFxdJ3dvGiTcR9bQa+3
 sQpokNEjtUcfoflPd8HqXlZdI6dQ4jDSktueZuyA2rfDfKNVZJ+LrBRVVqwRTylrvs1l
 ERIHAak0GGejhxjq3WLzQp1T+rAh9vp3TQxDT3sruwDJSVZZJeja9wqaZhFjt4Nn5He/
 UAbo2AZoP/2KBLUit1ILsWw+cafuEfWZmm9K5fsq84ZEC/bEdFnbLN8VxSSbkhiJO8et
 oR/4z5zx7L9EJJEJgwz2SXfyWUI93f3+720G0pRQdrpotZ5eMF6QEaJc1Y2xRgEWForl
 zEIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791231439; x=1791836239;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Zj1GsVK6MEWmNxZ1LapynJJcv+KBUbleHw06Rt4t2Gg=;
 b=kyujEr0sjRuPLp+GJRhLHhX0PF0dPZx7nuQzSils/OpAZCaqIBFDoDQn8kY9QcqRso
 5wi92O+WGi0NrRzZGN4aDAN36Mfm0yQiaEg+lpWfmo2AreCh4fxnosKFsIlMQ8U+loY/
 wmbIjZEB5zrL66NcFxrBO5kVxuHf4jPf+rrcvz/Vnc9ymd4uYY16NvrKttfdCTyrFVFz
 vx3tT+sPZTrk9NW/PFhBqJGZNqKz1x1kn68LyU14zB5wN/TANKH8CSq7JW/PZ1fI6EBH
 F+6ZM241HeQfVLOlMcl9J6R/tliU8POxE9+0hYbL6Oxo3AZPpjAFgDyrBv0PGbWDkngX
 kL3A==
X-Gm-Message-State: AFuF++kVIxCTYF20zkPPUWuau7fLO6MGfssKaV55c2YkuqihrFzL0rJL
 XYyjWe03VUANoCDyjI5FTMASRHNC1FeNwu6xFwROT/XnbeEdocGp0xD8D3Obaw7bAqs=
X-Gm-Gg: AYBFou1FiK8yMi7wwksBF8VN3KNxu28ujQj55Mefr3GgIS8rDMog25+6ZwIRMjHzWuR
 y2sE06OkYsQaADm/NiVZGOEEHdtr9cV+hvb8CGORg2P5HiygcEypoiQPfUI2NbcJHMJUQEdg9jH
 rjle+j+hAR3XL0gzEIkTMC/moeou/qM1nOAAJDNDeKsuc0VJhFguF27aXtjaH+NzbUkgDbmO5LM
 FcGfdKLsv3pVabkFKQad4dURd4eAAJxoChvlh4ikjyP3GWRo8NSyJSw10zrHbDAN+eXDTLrF8o8
 r8IVKb2+ycw5kKT2mX2lSCp2hIT3oCl0O7WGlWH4m7bXNsyrauzaqlZ+7+aVU1a6yqiIpnz73g2
 W25i6U4d1HdmZSdETghwlAvBmz1Mw2PuWY0JR6dKowoNOjA6SLjbQ5ZBBHjARZkcrzY2Vm0W7hw
 5xYKOAUKNlu5NQ7bgDwiinJOy/Dup++Yf8eGzKEOOo79JP0H3Acw0LfXGg+UwTaxs3rUz+Ije+y
 yFSr1FmGOjOyiUuYl6SekYYkgWXuhF0zr9daniy7Qt35fQpHGyR7qZvegeEZ/5PM+sHvTYM9JBF
 S3vPP9QWG8m0ZJiEhb9aLbPpSWEpGRgfU2J5J/JheAN38gG9koN1NFf2nfkvWGD6sG6W8mvNnlx
 w9lQcqeTSmsQVbU50LSSHHc4HqVey7KMj2pGMjYzcsYbRhPcQ3i0ay87p7pmziw2K
X-Received: by 2002:a05:6a20:9194:b0:3de:3f4d:f2b9 with SMTP id
 adf61e73a8af0-3e0bd23f397mr12753331637.39.1791231439062; 
 Mon, 05 Oct 2026 13:17:19 -0700 (PDT)
Received: from arter97-x1 ([58.124.177.116]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cce6ded2012sm1411117a12.21.2026.10.05.13.17.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Oct 2026 13:17:18 -0700 (PDT)
From: Juhyung Park <qkrwngud825@gmail.com>
To: linux-f2fs-devel@lists.sourceforge.net, jaegeuk@kernel.org,
 kernel-team@android.com
Date: Tue,  6 Oct 2026 05:17:11 +0900
Message-ID: <20261005201711.699080-1-qkrwngud825@gmail.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
X-Headers-End: 1xDp7k-00010y-Vx
Subject: [f2fs-dev] [PATCH] f2fs-tools: fix casefolded dentry hash for names
 that fold beyond F2FS_NAME_LEN
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

U2luY2Uga2VybmVsIGNvbW1pdCA0M2M3ODBiYTI2MjQgKCJmMmZzOiByZXdvcmsgZmlsZW5hbWUg
aGFuZGxpbmciLAp2NS44KSwgdGhlIGtlcm5lbCBjYXNlZm9sZHMgYSBuYW1lIGludG8gYW4gRjJG
U19OQU1FX0xFTiBidWZmZXIsIGFuZCBpZgp0aGUgZm9sZGVkIG5hbWUgZG9lc24ndCBmaXQsIGl0
IGZhbGxzIGJhY2sgdG8gaGFzaGluZyB0aGUgcmF3IG9uLWRpc2sKbmFtZSAoZjJmc19pbml0X2Nh
c2Vmb2xkZWRfbmFtZSgpKS4KCmYyZnNfZGVudHJ5X2hhc2goKSBzdGlsbCBmb2xkcyBpbnRvIGEg
UEFUSF9NQVggYnVmZmVyLCBhcyB0aGUgb3JpZ2luYWwKa2VybmVsIGltcGxlbWVudGF0aW9uIGRp
ZCwgc28gaXQgaGFzaGVzIHRoZSBmb2xkZWQgbmFtZSBpbnN0ZWFkLiBORkQKZGVjb21wb3NpdGlv
biBjYW4gZ3JvdyBhIG5hbWUgY29uc2lkZXJhYmx5IChlYWNoIDMtYnl0ZSBIYW5ndWwgc3lsbGFi
bGUKYmVjb21lcyA2LTkgYnl0ZXMpLCBzbyBhIHZhbGlkIDw9IDI1NS1ieXRlIG5hbWUgY2FuIGZv
bGQgdG8gbW9yZSB0aGFuCjI1NSBieXRlcy4gRm9yIHN1Y2ggYSBuYW1lLCBmc2NrLmYyZnMgY29t
cHV0ZXMgYSBkaWZmZXJlbnQgaGFzaCB0aGFuIHRoZQprZXJuZWwuIEl0IHRoZW4gImZpeGVzIiB0
aGUga2VybmVsLXdyaXR0ZW4gaGFzaF9jb2RlIHRvIGEgd3JvbmcgdmFsdWUsCmFuZCB0aGUgZmls
ZSBiZWNvbWVzIHVucmVhY2hhYmxlIHZpYSBsb29rdXAgKEVOT0VOVCkgdW5sZXNzIHRoZSBrZXJu
ZWwKZmFsbHMgYmFjayB0byBsaW5lYXIgbG9va3VwIChlLmcuIGxvb2t1cF9tb2RlPWNvbXBhdCku
IExhdGVyIGZzY2sgcnVucwpjb25zaWRlciB0aGUgYnJva2VuIGhhc2ggY29ycmVjdCBhbmQgcmVw
b3J0IG5vdGhpbmcuCgpUaGlzIHNpbGVudGx5IG1ha2VzIHVzZXIgZmlsZXMgdW5yZWFjaGFibGUg
b24gQW5kcm9pZCwgd2hlcmUgL2RhdGEvbWVkaWEKaXMgY2FzZWZvbGRlZCBhbmQgZnNjayBpcyB0
cmlnZ2VyZWQgb24gYSBmdWxsIE9UQSBhbmQgYSBrZXJuZWwgdmVyc2lvbgpjaGFuZ2UuIFRoaXMg
cGVyc29uYWxseSBoYXBwZW5lZCB0byBtZSBvbiBteSBkYWlseSBkcml2ZXIgdW5pdC4gU2luY2UK
dGhlIGJ1Z2d5IGZzY2sgY29uc2lkZXJzIGl0cyBvd24gaGFzaCBjb3JyZWN0IGFmdGVyd2FyZHMs
IHRoZSBkYW1hZ2UgaXMKbmV2ZXIgcmVwb3J0ZWQsIGFuZCBpdCByZXBlYXRzIGZvciBldmVyeSBu
ZXcgc3VjaCBmaWxlIHRoZSBrZXJuZWwKY3JlYXRlcy4KCk1pbmltYWwgcmVwcm9kdWNlcjoKCiAg
TkFNRT0kKHByaW50ZiAn6rCAJS4wcycgJChzZXEgNDMpKSAgIyAxMjkgYnl0ZXMgcmF3LCAyNTgg
Ynl0ZXMgZm9sZGVkCiAgdHJ1bmNhdGUgLXMgMTI4TSBjZi5pbWcKICBta2ZzLmYyZnMgLXEgLU8g
ZXh0cmFfYXR0cixjYXNlZm9sZCAtQyB1dGY4IGNmLmltZwogIG1vdW50IC1vIGxvb3AgY2YuaW1n
IG1udAogIG1rZGlyIG1udC9kICYmIGNoYXR0ciArRiBtbnQvZCAmJiB0b3VjaCAibW50L2QvJE5B
TUUiCiAgdW1vdW50IG1udAogIGZzY2suZjJmcyAtZiAteSBjZi5pbWcKICBtb3VudCAtbyBsb29w
LHJvIGNmLmltZyBtbnQKICBzdGF0ICJtbnQvZC8kTkFNRSIKCkJlZm9yZSB0aGlzIHBhdGNoLCBm
c2NrLmYyZnMgd3JvbmdmdWxseSBtb2RpZmllcyB0aGUgaGFzaCBhbmQgYnJlYWtzCmtlcm5lbCBs
b29rdXA6CgogIHN0YXQ6IGNhbm5vdCBzdGF0eCAnbW50L2Qv6rCA6rCA6rCA6rCA6rCA6rCA6rCA
6rCA6rCA6rCA6rCA6rCA6rCA6rCA6rCA6rCA6rCA6rCA6rCA6rCA6rCA6rCA6rCA6rCA6rCA6rCA
6rCA6rCA6rCA6rCA6rCA6rCA6rCA6rCA6rCA6rCA6rCA6rCA6rCA6rCA6rCA6rCA6rCAJzogTm8g
c3VjaCBmaWxlIG9yIGRpcmVjdG9yeQoKVXNlIGFuIEYyRlNfTkFNRV9MRU4gYnVmZmVyLCBhcyB0
aGUga2VybmVsIGRvZXMuIHV0ZjhfY2FzZWZvbGQoKSBhbHJlYWR5CnJldHVybnMgLUVOQU1FVE9P
TE9ORyBvbiBvdmVyZmxvdywgd2hpY2ggZmFsbHMgYmFjayB0byB0aGUgcmF3LW5hbWUgaGFzaC4K
V2l0aCB0aGlzLCBmc2NrLmYyZnMgbGVhdmVzIHRoZSByZXByb2R1Y2VyIGltYWdlIHVudG91Y2hl
ZCwgYW5kIGl0IGFsc28KcmVwYWlycyB0aGUgaGFzaGVzIHRoYXQgdGhlIGJ1Z2d5IHZlcnNpb24g
cHJldmlvdXNseSByZXdyb3RlLgoKRml4ZXM6IGNlNjRlYTA4MTViZiAoImYyZnMtdG9vbHM6IEFk
ZCBzdXBwb3J0IGZvciBDYXNlZm9sZGluZyIpClNpZ25lZC1vZmYtYnk6IEp1aHl1bmcgUGFyayA8
cWtyd25ndWQ4MjVAZ21haWwuY29tPgotLS0KIGxpYi9saWJmMmZzLmMgfCA0ICsrLS0KIDEgZmls
ZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEv
bGliL2xpYmYyZnMuYyBiL2xpYi9saWJmMmZzLmMKaW5kZXggOTNmMzZjYTZhMzBjLi43NWI3ZTFh
NzM3NmYgMTAwNjQ0Ci0tLSBhL2xpYi9saWJmMmZzLmMKKysrIGIvbGliL2xpYmYyZnMuYwpAQCAt
NDk5LDEwICs0OTksMTAgQEAgZjJmc19oYXNoX3QgZjJmc19kZW50cnlfaGFzaChpbnQgZW5jb2Rp
bmcsIGludCBjYXNlZm9sZGVkLAogCXVuc2lnbmVkIGNoYXIgKmJ1ZmY7CiAKIAlpZiAobGVuICYm
IGNhc2Vmb2xkZWQpIHsKLQkJYnVmZiA9IG1hbGxvYyhzaXplb2YoY2hhcikgKiBQQVRIX01BWCk7
CisJCWJ1ZmYgPSBtYWxsb2Moc2l6ZW9mKGNoYXIpICogRjJGU19OQU1FX0xFTik7CiAJCUFTU0VS
VChidWZmKTsKIAotCQlkbGVuID0gdGFibGUtPm9wcy0+Y2FzZWZvbGQodGFibGUsIG5hbWUsIGxl
biwgYnVmZiwgUEFUSF9NQVgpOworCQlkbGVuID0gdGFibGUtPm9wcy0+Y2FzZWZvbGQodGFibGUs
IG5hbWUsIGxlbiwgYnVmZiwgRjJGU19OQU1FX0xFTik7CiAJCWlmIChkbGVuIDwgMCkgewogCQkJ
ZnJlZShidWZmKTsKIAkJCWdvdG8gb3BhcXVlX3NlcTsKLS0gCjIuNTUuMAoKCgpfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpMaW51eC1mMmZzLWRldmVsIG1h
aWxpbmcgbGlzdApMaW51eC1mMmZzLWRldmVsQGxpc3RzLnNvdXJjZWZvcmdlLm5ldApodHRwczov
L2xpc3RzLnNvdXJjZWZvcmdlLm5ldC9saXN0cy9saXN0aW5mby9saW51eC1mMmZzLWRldmVsCg==
