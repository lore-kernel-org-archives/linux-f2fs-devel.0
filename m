Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E14F0CCA46C
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 16 Oct 2026 16:02:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:To:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=S/fGJzarfBGRtClmjkLXVUkm5aDZQxxhQkfwVPqzwWY=; b=B+wBxi4esRFZnDAz4bTxaKBnme
	sN1hKK7TXZGz2Vm2Q5378Ajbguwvie49aIy8CWC9UGtAAzzDHydy0Od8XBvCWTMFNAfzdCSggYgHK
	uRCxz0up6jKof8WdESTNoSccTMNULc3SsPLZb6RGXiqhFyLIBNIvuUft1OJI02UMuGfk=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xHkOW-000424-CK;
	Fri, 16 Oct 2026 16:02:56 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <daeho43@gmail.com>) id 1xHkOV-00041y-G7
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 16 Oct 2026 16:02:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:Cc:To:
 Subject:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=p6W0MzkJletU/sr7B+WwRQV/QfxWsVPQAXfOFMTAVd4=; b=bqdzflbaS8QzhQeoOKQL0cRenj
 Ijojc+RgYOJ8zyWCHP4hV21oaBbJW0XdlTZFLHnfaW5HL0+c+0rzj/AVfBMtdy9rPhw1lG00e9fE5
 qoiktCpAcgISblWYnR9AH/MnaNurxcztPCOmXg18Iy9yXlWf050m6zXblTZ+YVenk0zw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:Cc:To:Subject:Message-ID:Date:From
 :In-Reply-To:References:MIME-Version:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=p6W0MzkJletU/sr7B+WwRQV/QfxWsVPQAXfOFMTAVd4=; b=M7M54YQ2YiAbmZyPMZw1Ij1PvB
 fRxjJU5mq4f/HnPJ663PaUJ8OuV6D8ZwpVo+EHMfASC0IF94bBCt81fENvDxemCmVPxYf16/DB3Pt
 BRDoQuHaJc1oeyej5TrX9x6qHeeHhsoC2yHHanyE0nYYcT3KOxDutcyTJGdBYeZLjS1Y=;
Received: from mail-pg1-f179.google.com ([209.85.215.179])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xHkOR-0001kD-92 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 16 Oct 2026 16:02:55 +0000
Received: by mail-pg1-f179.google.com with SMTP id
 41be03b00d2f7-cc4c02ddd62so91885a12.0
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri, 16 Oct 2026 09:02:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792166565; cv=none;
 d=google.com; s=arc-20260327;
 b=siAxAQSF722UNPxbT6l43pphdJFnNjt9byOAq3wA7IftrQ01XmIWPISQsevZe8CS4V
 P/4JFThMfM5tKZ7Jd0+NVFeY7p2pyUYrKnc9W5GSSrgnqMRSX/ahDKmrCZAI+wK0xC7l
 WHKr8vz4g/wUiBVRgj9BYhYYUikpe7jd26584ON3E+MG9lYfwbZpPN5/tIFow42z6ZD3
 Ux+pmFH9G0+B0ly7KhsS2qHJ6N8HkJV5smuA21WoJzdKVTGKlTLqgOjzEuN3Eop8K4hC
 7kfIytSPQgg+82OU7gIK3z7dU0roumhzV2gkSZY1njoDu+g7vzoKVWq8KmXg3KLUADQX
 qvEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=p6W0MzkJletU/sr7B+WwRQV/QfxWsVPQAXfOFMTAVd4=;
 fh=5ik+tafqBw/mW8+jYSXPtLNBxBAOvNRjSeLM5fD93fo=;
 b=UQ2v04RH9u2Uhqp2fOoG8x3c2LR+iWhKhFAJ3whpEuSoYx114MmMcMOLdFhVZd4jr9
 975F99VtsVjX1lmcTEDBp53VBp0oQM1lo16iXrQn05Yw+lGHsATcrcKeKZEwMbAurp3L
 cCEGwIlxh/y2qdXhv3JF5vIyJ/AcKBbdDFgqv1UFz/7RNAvfC6wOeuTZTpbHFn7ikRU9
 ULXcmZrF8Mj1QOTC8kizs+jQsSsrPVnFD00UFWpTQSvRCMkCEtLdb7C23vFPPpisp0iI
 amRNhfNVfTZ+XDrWvqLDzeVGd4hT7LYOZAUSZPlM7Pr4oyLCzLU3u1eY4UzEKSU2WA8e
 8Dmg==; darn=lists.sourceforge.net
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792166565; x=1792771365; darn=lists.sourceforge.net;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=p6W0MzkJletU/sr7B+WwRQV/QfxWsVPQAXfOFMTAVd4=;
 b=ZcNLzwBI3MrVpydV3WY7lisEcj7a87E6T/+ymaTIUCS/93J5ZFRApFuHxLQ8HuXsm8
 X5ocOKaYQ8EB6x2t9jOKAT229d0rEd98B56x+lHnUImbsMSL1YSDcHh9UNcvAqhCU9gW
 yH4IrIyGJi+N23hw3aeQFieyIPN7ckBvkR2Ivwgu1gWBbnVl8LL8pxI3KRHiHEWWS8BQ
 NqVy2janmgN7zzxDLFhOZWIy/LkALQrcpXLkUPvTyMBxE+oR6M9Ac0hnfyyi+jdAX/56
 evPMPocr/EwVCIfTQrz8ody4294AXFX9mtIBwzaw7khnuIQKImHMkJBPGrTZudmXjsLZ
 Cx3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792166565; x=1792771365;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=p6W0MzkJletU/sr7B+WwRQV/QfxWsVPQAXfOFMTAVd4=;
 b=aIVfSOY0OdV9ZK8IejeWClAtSnmILn1ZSdhwSORQb4ULa17qwVg6tlUC1KIfxSWWrG
 krU1ga+3bDrcgfcG8R2KAkkpHv+cSC/xvzcXgspjFriMgYK1theFC2gAm5ygtSC5OEQx
 8dHnhlQMc3YFld31QxUukDDYtGEEH6NQEvsikXk7aw5zbu8KaEfguZ31h4DybAfCqHA/
 MZm2cVgWg5xrhdfhzMGpgKiUNP+xhE0b7SbYpzLUvWlHVZND9j/9DX6SAbRMN0ot4lQL
 oHW59dDihdmIwBSS/W+k8ixO7HAuM0HkC5oQrxJmGG3MyZTXc5X1Bqd9zjW0f5p3ig0p
 u8og==
X-Forwarded-Encrypted: i=1;
 AKwUvBylSvHoTaVOhH4dJHMA9LPRaNFOjOyYQvns8VUOmaNpnZpmtaBFFlUCtoz/dYfcmuiz+ZeVM1TY/IvMkbuqVfeg@lists.sourceforge.net
X-Gm-Message-State: AFq9FYKyFDeh80VC+C2AU50D4DmiQOvc+4D7knGc6IjXOw48vqeRL9LA
 2/2EciuDG9SVIxhZYETpQX3Dnj2B5HyEJR7ts0Dyj6R5fW7GGTllZBhRYWQPm/30WeuGwcL/8nh
 t7tvpvXExtLyX99XtqnMbW2YtLGj1CQw=
X-Gm-Gg: AYBFou0D49Edmg1lO/1/dO2I8QjguBjzLTvlJVatCXh0OkgYvGhgKWyACLT+6sRnByH
 ENY0XAQLaFo6OAlKSGso4yM5HnP6rIMB+TFTD7Wso2pH/sk8lFPTYsDdLIyPkHJ3oT1i21Nd94g
 xLO77660o5Xn60rJEjcszbyHvxG/Y2xPWp9eVm0eafOhj8VNQz+A5hOARrUiRF3G1xTvZq6wSqq
 ncnzcJGye36sI3WSI2tlLhokUCwo/T3VfJj6cPIRIYTXijol+vTYpwtxpFm6rDZGG6QN0BcGe0w
 XskvR/QjBIYfW8XYC9Lx3C+H1p3DDgkO32e/ds/cP622eeObZ1MI/w0yRINiQdFHF//y8y9Zdci
 nxLaCMoyYJUWBENcphabiYr4QqIlm9klyLoTCx3jWbqTwdnm1WgFoHF4=
X-Received: by 2002:a05:6a21:4ea8:b0:3cc:92d9:80cb with SMTP id
 adf61e73a8af0-3e16bf7b29amr19368926637.12.1792166565245; Fri, 16 Oct 2026
 09:02:45 -0700 (PDT)
MIME-Version: 1.0
References: <20261016021737.4121867-1-chao@kernel.org>
In-Reply-To: <20261016021737.4121867-1-chao@kernel.org>
From: Daeho Jeong <daeho43@gmail.com>
Date: Fri, 16 Oct 2026 09:02:31 -0700
X-Gm-Features: AclHuK-iEUih5Z3WE9v_5gQnnB8d6hXT8gHW-l_9UdcQgvGf7HR15nb1PCXYFVE
Message-ID: <CACOAw_z0cRcUg5R33dBnVsJrdeKL=4_xL+vxRsAjQPSSRc91CA@mail.gmail.com>
To: Chao Yu <chao@kernel.org>
X-Headers-End: 1xHkOR-0001kD-92
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix to avoid potential reference count
 leak in do_garbage_collect()
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

T24gVGh1LCBPY3QgMTUsIDIwMjYgYXQgNzoyMuKAr1BNIENoYW8gWXUgdmlhIExpbnV4LWYyZnMt
ZGV2ZWwKPGxpbnV4LWYyZnMtZGV2ZWxAbGlzdHMuc291cmNlZm9yZ2UubmV0PiB3cm90ZToKPgo+
IEZyb206IENoYW8gWXUgPGNoYW9Aa2VybmVsLm9yZz4KPgo+IEluIGRvX2dhcmJhZ2VfY29sbGVj
dCgpLCB3ZSBoYXZlIHJlc2VydmVkIHJlZmVyZW5jZSBjb3VudHMgb24gc3VtbWFyeSBjYWNoZQo+
IG9mIGFsbCBzZWdtZW50cywgb25jZSBnY190aHJlYWQgZW5jb3VudGVyIGZyZWV6aW5nLCB3ZSBu
ZWVkIHRvIHJlbGVhc2UgYWxsCj4gcmVmZXJlbmNlIGNvdW50cy4KPgo+IENjOiBzdGFibGVAa2Vy
bmVsLm9yZwo+IENjOiBEYWVobyBKZW9uZyA8ZGFlaG9qZW9uZ0Bnb29nbGUuY29tPgo+IEZpeGVz
OiAwMmQ5MTM5OGE2MDIgKCJmMmZzOiBmaXggdG8gZnJlZXplIEdDIGFuZCBkaXNjYXJkIHRocmVh
ZHMgcXVpY2tseSIpCj4gU2lnbmVkLW9mZi1ieTogQ2hhbyBZdSA8Y2hhb0BrZXJuZWwub3JnPgo+
IC0tLQo+ICBmcy9mMmZzL2djLmMgfCAxMCArKystLS0tLS0tCj4gIDEgZmlsZSBjaGFuZ2VkLCAz
IGluc2VydGlvbnMoKyksIDcgZGVsZXRpb25zKC0pCj4KPiBkaWZmIC0tZ2l0IGEvZnMvZjJmcy9n
Yy5jIGIvZnMvZjJmcy9nYy5jCj4gaW5kZXggNWJiMTE3ZTVlODExLi5hZDZmNjA0Y2MyN2YgMTAw
NjQ0Cj4gLS0tIGEvZnMvZjJmcy9nYy5jCj4gKysrIGIvZnMvZjJmcy9nYy5jCj4gQEAgLTE5MDEs
NiArMTkwMSw5IEBAIHN0YXRpYyBpbnQgZG9fZ2FyYmFnZV9jb2xsZWN0KHN0cnVjdCBmMmZzX3Ni
X2luZm8gKnNiaSwKPiAgICAgICAgICAgICAgICAgaWYgKGJsb2NrX2VuZF9zZWdubyA+IGVuZF9z
ZWdubykKPiAgICAgICAgICAgICAgICAgICAgICAgICBibG9ja19lbmRfc2Vnbm8gPSBlbmRfc2Vn
bm87Cj4KPiArICAgICAgICAgICAgICAgaWYgKHVubGlrZWx5KGZyZWV6aW5nKGN1cnJlbnQpKSkK
PiArICAgICAgICAgICAgICAgICAgICAgICBnb3RvIG5leHRfYmxvY2s7Cj4gKwo+ICAgICAgICAg
ICAgICAgICBpZiAoaXNfY3Vyc2VjKHNiaSwgR0VUX1NFQ19GUk9NX1NFRyhzYmksIHNlZ25vKSkp
IHsKPiAgICAgICAgICAgICAgICAgICAgICAgICBmMmZzX2VycihzYmksICIlczogc2VnbWVudCAl
dSBpcyB1c2VkIGJ5IGxvZyIsCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICBfX2Z1bmNfXywgc2Vnbm8pOwo+IEBAIC0xOTY4LDEyICsxOTcx
LDYgQEAgc3RhdGljIGludCBkb19nYXJiYWdlX2NvbGxlY3Qoc3RydWN0IGYyZnNfc2JfaW5mbyAq
c2JpLAo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgc2JpLT5uZXh0X3ZpY3RpbV9z
ZWdbZ2NfdHlwZV0gPQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAo
Y3VyX3NlZ25vICsgMSA8IHNlY19lbmRfc2Vnbm8pID8KPiAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgY3VyX3NlZ25vICsgMSA6IE5VTExfU0VHTk87Cj4gLQo+IC0gICAg
ICAgICAgICAgICAgICAgICAgIGlmICh1bmxpa2VseShmcmVlemluZyhjdXJyZW50KSkpIHsKPiAt
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGYyZnNfcHV0X2NhY2hlKHN1bV9lbnRyeSwg
ZmFsc2UpOwo+IC0gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgZjJmc19wdXRfY2FjaGUo
c3VtX2VudHJ5LCBmYWxzZSk7Cj4gLSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBnb3Rv
IHN0b3A7Cj4gLSAgICAgICAgICAgICAgICAgICAgICAgfQo+ICAgICAgICAgICAgICAgICB9Cj4g
IG5leHRfYmxvY2s6Cj4gICAgICAgICAgICAgICAgIGYyZnNfcHV0X2NhY2hlKHN1bV9lbnRyeSwg
ZmFsc2UpOwo+IEBAIC0xOTgxLDcgKzE5NzgsNiBAQCBzdGF0aWMgaW50IGRvX2dhcmJhZ2VfY29s
bGVjdChzdHJ1Y3QgZjJmc19zYl9pbmZvICpzYmksCj4gICAgICAgICAgICAgICAgIHNlZ25vID0g
YmxvY2tfZW5kX3NlZ25vOwo+ICAgICAgICAgfQo+Cj4gLXN0b3A6Cj4gICAgICAgICBpZiAoc3Vi
bWl0dGVkKQo+ICAgICAgICAgICAgICAgICBmMmZzX3N1Ym1pdF9tZXJnZWRfd3JpdGUoc2JpLCBk
YXRhX3R5cGUpOwo+Cj4gLS0KPiAyLjQ5LjAKPgo+CgpSZXZpZXdlZC1ieTogRGFlaG8gSmVvbmcg
PGRhZWhvamVvbmdAZ29vZ2xlLmNvbT4KClRoYW5rcywKCj4KPiBfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwo+IExpbnV4LWYyZnMtZGV2ZWwgbWFpbGluZyBs
aXN0Cj4gTGludXgtZjJmcy1kZXZlbEBsaXN0cy5zb3VyY2Vmb3JnZS5uZXQKPiBodHRwczovL2xp
c3RzLnNvdXJjZWZvcmdlLm5ldC9saXN0cy9saXN0aW5mby9saW51eC1mMmZzLWRldmVsCgoKX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTGludXgtZjJmcy1k
ZXZlbCBtYWlsaW5nIGxpc3QKTGludXgtZjJmcy1kZXZlbEBsaXN0cy5zb3VyY2Vmb3JnZS5uZXQK
aHR0cHM6Ly9saXN0cy5zb3VyY2Vmb3JnZS5uZXQvbGlzdHMvbGlzdGluZm8vbGludXgtZjJmcy1k
ZXZlbAo=
