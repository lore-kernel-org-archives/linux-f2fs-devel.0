Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DAA5CD343F
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 15 May 2026 18:04:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:References:
	Message-ID:To:Date:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=I6Ng5eGy7Hz1oh64bhhMdLqb/mNVM0rFQcCTh5E5ARE=; b=Vr0GLwh7IxWT5T5lTZNg1S7fxI
	InMIiGnTRlluMWOwAeM/NlWyJVqrckT1IN0qY4PVvu9HGFqbVm/DcjScjjMbKlh7kLJ7Xx6kWTCxB
	VoFwjdCEM3ECvQRG5KLdJX1BcduWXbfqMWlqYiIYqxLxWZWNRDX/ctJIaf0DZwIJUgVs=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wNwtw-0000sB-Hx;
	Fri, 15 May 2026 18:04:45 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <zlang@kernel.org>) id 1wNwtv-0000rt-13
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 15 May 2026 18:04:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Transfer-Encoding:Content-Type:
 MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=oOuJ5+DvNq0Q525lYdXFKtVIktD80jGFMItG7ed2HA4=; b=ROfElig8pk4mxdueGqVk2n4qtp
 2ci5waP68+1CPHoV5VhzcyB8bfU6w0SmNt6JM17Ns5tcyQ0NC4oIrDRKSWN8VuZEkPcj/GtgavQt3
 eg2V7o341nJIgXXlOzofVw/hERRCHdgmgjRyMs0JMXynk3+drIYYq/rKB/cwn+3WvZSg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=oOuJ5+DvNq0Q525lYdXFKtVIktD80jGFMItG7ed2HA4=; b=dzvwxDXQMRIs7etJcraQtiXcIn
 6Eh1mQ0hoFNI3qnTUeJ6F+Yhm01baKs/FWzW6fHsgW2EMbVcShZqWnTaeATPOWISdguzunYjNHnCX
 8rRRUdJU5gW/U3es+Tm4BBWpvk28c7kTZw044u1YqiuNIwQ4sQgMiQlBuJVb2GVvh+hY=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wNwtt-0005bJ-Si for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 15 May 2026 18:04:43 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 0423E441C2;
 Fri, 15 May 2026 18:04:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59CD7C2BCB0;
 Fri, 15 May 2026 18:04:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1778868271;
 bh=hhyluz44ErbSva2TqSzBKP/tzE4T6Ba2VRDiTMCqGwA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=nK4P7rjY9S8MOvaXom/f/mpIqZTSILZKg4UUZy6hX+VWmuEe1g1ofq6L4pJABNEim
 YU3xe5gtJK9w24wcFykTnziO0sbcZ2mgbYhCHnz7D6wVLCWJcM+dzpDzt/DBgcA40F
 NfSH7jfIVITQNvI8WCKjXjjHezcQBatzsEV0yXwerxLZNVrf45ubZNQsoyWTn7udcg
 UUjfDViJTTpedsQhN0ELFEzbZgXFm1jtf4iGYV/5G6Nn3DlbdXXOp7I01ohenutOM/
 YbvvReiJKTVFGD0CRtUSZcKFYbhF8ueMDiJ8/d2fJ2ISD4DhmPxUT5ANNHwXQMM+JM
 fLtVkhoimHMlQ==
Date: Sat, 16 May 2026 02:04:23 +0800
To: Joanne Chang <joannechien@google.com>
Message-ID: <agddkrLATA8noIQ0@zlang-mailbox>
Mail-Followup-To: Joanne Chang <joannechien@google.com>, 
 fstests@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>, 
 linux-f2fs-devel@lists.sourceforge.net, Chao Yu <chao@kernel.org>
References: <20260513032009.2300435-1-joannechien@google.com>
 <20260513032009.2300435-2-joannechien@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260513032009.2300435-2-joannechien@google.com>
X-Headers-End: 1wNwtt-0005bJ-Si
Subject: Re: [f2fs-dev] [PATCH v1 2/2] f2fs/021: Fix mount syntax for
 disabling jquota
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
From: Zorro Lang via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Zorro Lang <zlang@kernel.org>
Cc: Jaegeuk Kim <jaegeuk@kernel.org>, fstests@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

T24gV2VkLCBNYXkgMTMsIDIwMjYgYXQgMDM6MjA6MDlBTSArMDAwMCwgSm9hbm5lIENoYW5nIHdy
b3RlOgo+IEYyRlMgaGFzIHJlbW92ZWQgdGhlIHRyYWlsaW5nICI9IiBpbiB0aGUgbW91bnQgb3B0
aW9ucyBmb3IgZGlzYWJsaW5nCj4gdXNlciBqb3VybmFsZWQgcXVvdGFzLiBVcGRhdGUgZjJmcy8w
MjEgdG8gdHJ5IHRoZSBuZXcgc3ludGF4IGZpcnN0IGFuZAo+IGZhbGwgYmFjayB0byB0aGUgbGVn
YWN5IHN5bnRheCBpZiB0aGUgaW5pdGlhbCBtb3VudCBhdHRlbXB0IGZhaWxzLgo+IAo+IFNpZ25l
ZC1vZmYtYnk6IEpvYW5uZSBDaGFuZyA8am9hbm5lY2hpZW5AZ29vZ2xlLmNvbT4KPiAtLS0KPiAg
dGVzdHMvZjJmcy8wMjEgfCA0ICsrKy0KPiAgMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygr
KSwgMSBkZWxldGlvbigtKQo+IAo+IGRpZmYgLS1naXQgYS90ZXN0cy9mMmZzLzAyMSBiL3Rlc3Rz
L2YyZnMvMDIxCj4gaW5kZXggMGNhY2IxMzguLjcwYjEwZmE4IDEwMDc1NQo+IC0tLSBhL3Rlc3Rz
L2YyZnMvMDIxCj4gKysrIGIvdGVzdHMvZjJmcy8wMjEKPiBAQCAtMjEsNyArMjEsOSBAQCBxdW90
YWNoZWNrIC11YyAkU0NSQVRDSF9NTlQKPiAgX3NjcmF0Y2hfdW5tb3VudAo+ICAKPiAgX3NjcmF0
Y2hfbW91bnQgIi1vIHVzcmpxdW90YT1hcXVvdGEudXNlcixqcWZtdD12ZnNvbGQiCj4gLV9zY3Jh
dGNoX21vdW50ICItbyByZW1vdW50LHVzcmpxdW90YT0sanFmbXQ9dmZzb2xkIgo+ICtpZiAhIF90
cnlfc2NyYXRjaF9tb3VudCAiLW8gcmVtb3VudCx1c3JqcXVvdGEsanFmbXQ9dmZzb2xkIiA+PiAk
c2VxcmVzLmZ1bGwgMj4mMTsgdGhlbgo+ICsJX3NjcmF0Y2hfbW91bnQgIi1vIHJlbW91bnQsdXNy
anF1b3RhPSxqcWZtdD12ZnNvbGQiCj4gK2ZpCgpJ4oCZdmUgZXhwbG9yZWQgc2V2ZXJhbCB3YXlz
IHRvIHNvbHZlIHRoaXMgbW9yZSBlbGVnYW50bHkuIE90aGVyd2lzZSwgZXZlcnkKc2luZ2xlIEYy
RlMgcXVvdGEgdGVzdCBjYXNlIG1pZ2h0IHJ1biBpbnRvIHRoaXMgZXhhY3Qgc2FtZSBpc3N1ZS4g
YnV0IEkgY2FuJ3QKZmluZCBhbnkgZ29vZCBpZGVhIGN1cnJlbnRseS4gRm9yIGV4YW1wbGUsIGlm
IHdlIGRvIHNvbWV0aGluZyBpbiBfdHJ5X3NjcmF0Y2hfbW91bnQ6CgoJbG9jYWwgbW91bnRfb3B0
cz1gX3NjcmF0Y2hfbW91bnRfb3B0aW9ucyAkKmAKCWlmIFsgIiRGU1RZUCIgPT0gImYyZnMiIF07
IHRoZW4KCQltb3VudF9vcHRzPWBfZjJmc19xdW90YV9vcHRpb25zICIkbW91bnRfb3B0cyJgCglm
aQoKSG93ZXZlciwgRjJGUyBzZWVtcyB0byBvbmx5IGRpc3Rpbmd1aXNoIHRoZSAnPScgdXNhZ2Ug
dGhyb3VnaCBhIHRyaWFsIG1vdW50LApzbyBkb2luZyBpdCBpbnNpZGUgX3RyeV9zY3JhdGNoX21v
dW50IGlzIGRlZmluaXRlbHkgbm90IGEgZ29vZCBpZGVhLiBJcyB0aGVyZQphIHdheSB0byBwcm9i
ZSB0aGlzIHdpdGhvdXQgbW91bnRpbmc/IExpa2UgcmVseWluZyBvbiBzb21lIC0taGVscCBvdXRw
dXQgb3IKc29tZXRoaW5nIHNpbWlsYXI/IEFueSBnb29kIGlkZWFzIGZyb20gb3RoZXJzPwoKVGhh
bmtzLApab3JybwoKPiAgX3NjcmF0Y2hfdW5tb3VudAo+ICAKPiAgZWNobyAiU2lsZW5jZSBpcyBn
b2xkZW4iCj4gLS0gCj4gMi41NC4wLjU2My5nNGY2OWI0N2I5NC1nb29nCj4gCgoKX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTGludXgtZjJmcy1kZXZlbCBt
YWlsaW5nIGxpc3QKTGludXgtZjJmcy1kZXZlbEBsaXN0cy5zb3VyY2Vmb3JnZS5uZXQKaHR0cHM6
Ly9saXN0cy5zb3VyY2Vmb3JnZS5uZXQvbGlzdHMvbGlzdGluZm8vbGludXgtZjJmcy1kZXZlbAo=
