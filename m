Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1844BC5DF87
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 20 Aug 2026 11:46:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:To:Message-ID:Date:In-Reply-To:References:
	MIME-Version:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=s7Qedk6yUCVL4qNeZpnBR+FI7tmt3CanPPqFbfUe4/w=; b=hbx/ktpCgPgaSIZ6lYDZA7M/UW
	l473LxvKMOwq5wlMSMSsLAklp8bGRmh9cwUfMQ87IUE/P2Ao7HeRF/p9zP6KLyaPQpwVP/tOYEMqy
	35G1FSDmXVtvlPlC+e6kbez4YZ18TzJ55UVJSeJRbMd5Fz7NG+V7aJU1w953L9bMrHFA=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wx1Dg-0002Xw-So;
	Thu, 20 Aug 2026 11:46:04 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <baohua@kernel.org>) id 1wx1Dg-0002Xq-5l
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 20 Aug 2026 11:46:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:Cc:To:
 Subject:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=v+b4j/a5FImU0NqEfsd91iAyBN5l8n6hn3Cb567Mn3Y=; b=RQoSSquiBZWNuRXzLJoE63Edc+
 GfgSrGhZ4GcqgGXPh2FtqtSoD9zuUJUrIFx8d9Lr98qqJ2woT/wManHjLwLhDGn1IIFLD7b06XTpP
 Yz8Q31QEBa8R0hxOjaa7WuBFfGH9V0TYp5shvUAwhpFfHIu1lsi5+33UUWoeg9EtuEyE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:Cc:To:Subject:Message-ID:Date:From
 :In-Reply-To:References:MIME-Version:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=v+b4j/a5FImU0NqEfsd91iAyBN5l8n6hn3Cb567Mn3Y=; b=bNkq1ugL5F6heIAKbdu9UNI71l
 +49v3vJzr4+GwtDrErJvOBs0glUV0Y9/tQjdenzcJ2FaAhh5uX6292Kv6CbPJC+L+u7KNVO3St1TE
 sRzhN2ytoMmI2D6emNcJvjTL1B9wOWYbsl5Oug6+HmMQHgytCqxk6wt2+h4TBtPvaR68=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wx1De-00085A-M4 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 20 Aug 2026 11:46:04 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 21602406DD
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu, 20 Aug 2026 11:45:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05DAE1F00A3D
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu, 20 Aug 2026 11:45:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787226357;
 bh=v+b4j/a5FImU0NqEfsd91iAyBN5l8n6hn3Cb567Mn3Y=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc;
 b=M54IBjQf6aqE/mgNAEhcjhVIBH072Qv19i65hLEm7/z2YpGLt06S6MkEB5xlBDE/q
 i1VE+gPCkkFInHD70C25ibiDZQHPpEXeaDDHIUESKLdqXpIaVwRIPVYhPg6tPWPUc1
 NfanemuUdS2BrqUclJESHZ9PxPgE3GKbZsR4XIvVX0shoDXLMbwiiL5cOvhLwCkQW/
 cCOIFHyYpDkNlE7J7AaXsh1kxkXoBwhUNBmTqAcd82BOT8Z/SwLULmDXPbhhRrf6f3
 alSnl8OlVVfEytKENLCNJTDXlxxzbqbLrRGnBMA7Mg9ITd7/0Kc1lkDP5NJuRe+eGM
 IReGaKcchysEQ==
Received: by mail-qv1-f53.google.com with SMTP id
 6a1803df08f44-8f0e5e36912so14582806d6.2
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu, 20 Aug 2026 04:45:56 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AHgh+RrFe9CmJxjGbX1W8J5rLXU9rMMwOnwk35UQSlluLhF5I27dG1OaXvPz/0J1UG90RtwQYGdF37fVxv76mXIRQl+V@lists.sourceforge.net
X-Gm-Message-State: AOJu0Yw498tiILYj9htVNMl7rHo6W4mV0cwcdmgfXtZ0TeqL6MnEwHWR
 sDFxmZS2ZRjeOmXa97JfXJZcBM/IrRXTm+LkkWE7kGrA4g+Hu3YMUXm/eN5FOSTYtwG4zQuIT/k
 2BSFU28aADNjqlkNUJeAu25iOO+MRUp8=
X-Received: by 2002:a05:620a:648a:b0:92e:520a:ffab with SMTP id
 af79cd13be357-9371e443ad4mr1169050685a.38.1787226356372; Thu, 20 Aug 2026
 04:45:56 -0700 (PDT)
MIME-Version: 1.0
References: <20260820071438.695893-1-qiwenjie@xiaomi.com>
 <20260820071438.695893-2-qiwenjie@xiaomi.com>
In-Reply-To: <20260820071438.695893-2-qiwenjie@xiaomi.com>
Date: Thu, 20 Aug 2026 19:45:43 +0800
X-Gmail-Original-Message-ID: <CAGsJ_4wQZUZLBxOaRt-ax4QBRaa5PNf+xpJrT_b=rZzyhDGLkA@mail.gmail.com>
X-Gm-Features: AcwNN1XcSSF4aBbOGKEf77hoh77gcWtUdb9nAy1OqmpMXY8xBpf3ci2unplmbZ8
Message-ID: <CAGsJ_4wQZUZLBxOaRt-ax4QBRaa5PNf+xpJrT_b=rZzyhDGLkA@mail.gmail.com>
To: Wenjie Qi <qwjhust@gmail.com>
X-Headers-End: 1wx1De-00085A-M4
Subject: Re: [f2fs-dev] [PATCH v2 1/2] f2fs: complete dropbehind write bios
 in safe task context
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
From: Barry Song via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Barry Song <baohua@kernel.org>
Cc: jaegeuk@kernel.org, qiwenjie@xiaomi.com, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

T24gVGh1LCBBdWcgMjAsIDIwMjYgYXQgMzoyMeKAr1BNIFdlbmppZSBRaSA8cXdqaHVzdEBnbWFp
bC5jb20+IHdyb3RlOgo+Cj4gQnVmZmVyZWQgUldGX0RPTlRDQUNIRSB3cml0ZXMgaW52YWxpZGF0
ZSBkcm9wYmVoaW5kIGZvbGlvcyBmcm9tIHdyaXRlYmFjawo+IGNvbXBsZXRpb24uIEtlZXAgbm9y
bWFsIGFuZCBkcm9wYmVoaW5kIGZvbGlvcyBpbiBzZXBhcmF0ZSB3cml0ZSBiaW9zLCBhbmQKPiBk
ZWZlciBhIGRyb3BiZWhpbmQgYmlvIHRvIHNiaS0+d3EgdW5sZXNzIGNvbXBsZXRpb24gcnVucyBp
bgo+IHByZWVtcHRpYmxlIHRhc2sgY29udGV4dC4KPgo+IFVzZSB0aGUgc2FtZSBlbGlnaWJpbGl0
eSBjb25kaXRpb25zIGFzIHRoZSBwcm9wb3NlZCBiaW9faW5fYXRvbWljKCkgaGVscGVyLgo+IFVu
bGlrZSAhaW5fdGFzaygpLCB0aGlzIGFsc28gY292ZXJzIGRpc2FibGVkIHByZWVtcHRpb24gYW5k
IHByZWVtcHRpYmxlIFJDVQo+IHJlYWQtc2lkZSBjcml0aWNhbCBzZWN0aW9ucy4KPgo+IEtlZXAg
dGhlIGV4aXN0aW5nIGxhcmdlLUFUQyBkZWZlcnJhbCB1bmNoYW5nZWQuCj4KPiBMaW5rOiBodHRw
czovL2xvcmUua2VybmVsLm9yZy9saW51eC1tbS8yMDI2MDczMC1ibGstZG9udGNhY2hlLXY3LTAt
M2U4ZTY4NTAwNjhkQGNvbHVtYmlhLmVkdS8KPiBTaWduZWQtb2ZmLWJ5OiBXZW5qaWUgUWkgPHFp
d2VuamllQHhpYW9taS5jb20+Cj4gLS0tCj4gIGZzL2YyZnMvZGF0YS5jIHwgNTAgKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrLS0tLS0tLS0KPiAgMSBmaWxlIGNoYW5n
ZWQsIDQyIGluc2VydGlvbnMoKyksIDggZGVsZXRpb25zKC0pCj4KPiBkaWZmIC0tZ2l0IGEvZnMv
ZjJmcy9kYXRhLmMgYi9mcy9mMmZzL2RhdGEuYwo+IGluZGV4IDZhZTBlYjM3ZDIwLi43NzRhM2Uy
ZDhlMyAxMDA2NDQKPiAtLS0gYS9mcy9mMmZzL2RhdGEuYwo+ICsrKyBiL2ZzL2YyZnMvZGF0YS5j
Cj4gQEAgLTIxLDYgKzIxLDcgQEAKPiAgI2luY2x1ZGUgPGxpbnV4L2ZpZW1hcC5oPgo+ICAjaW5j
bHVkZSA8bGludXgvaW9tYXAuaD4KPiAgI2luY2x1ZGUgPGxpbnV4L2ZzZXJyb3IuaD4KPiArI2lu
Y2x1ZGUgPGxpbnV4L3JjdXBkYXRlLmg+Cj4KPiAgI2luY2x1ZGUgImYyZnMuaCIKPiAgI2luY2x1
ZGUgIm5vZGUuaCIKPiBAQCAtNDMsOSArNDQsMjkgQEAgc3RydWN0IGYyZnNfZm9saW9fc3RhdGUg
ewo+Cj4gIHN0cnVjdCBmMmZzX2JpbyB7Cj4gICAgICAgICBzdHJ1Y3Qgd29ya19zdHJ1Y3Qgd29y
azsKPiArICAgICAgIGJvb2wgZHJvcGJlaGluZDsKPiAgICAgICAgIHN0cnVjdCBiaW8gYmlvOwo+
ICB9Owo+Cj4gK3N0YXRpYyBzdHJ1Y3QgZjJmc19iaW8gKnRvX2YyZnNfYmlvKHN0cnVjdCBiaW8g
KmJpbykKPiArewo+ICsgICAgICAgcmV0dXJuIGNvbnRhaW5lcl9vZihiaW8sIHN0cnVjdCBmMmZz
X2JpbywgYmlvKTsKPiArfQo+ICsKPiArLyogS2VlcCBpbiBzeW5jIHdpdGggdGhlIHByb3Bvc2Vk
IGJsb2NrLWxheWVyIGJpb19pbl9hdG9taWMoKS4gKi8KPiArc3RhdGljIGJvb2wgZjJmc19iaW9f
aW5fYXRvbWljKHZvaWQpCj4gK3sKPiArI2lmZGVmIENPTkZJR19QUkVFTVBUSU9OCj4gKyAgICAg
ICBpZiAocmN1X3ByZWVtcHRfZGVwdGgoKSkKPiArICAgICAgICAgICAgICAgcmV0dXJuIHRydWU7
Cj4gKyNlbmRpZgo+ICsjaWZuZGVmIENPTkZJR19QUkVFTVBUX0NPVU5UCj4gKyAgICAgICByZXR1
cm4gdHJ1ZTsKPiArI2Vsc2UKPiArICAgICAgIHJldHVybiAhcHJlZW1wdGlibGUoKTsKPiArI2Vu
ZGlmCj4gK30KPiArCgpIaSBXZW5qaWUsCgpJIHNlZSB0aGF0IHRoaXMgWzFdIGhhcyBhbHJlYWR5
IGJlZW4gaW5jbHVkZWQgaW4gdGhlIHB1bGwgcmVxdWVzdCBbMl0sCnNvIHBlcmhhcHMgeW91IGNh
biB1c2UgYmlvX2luX2F0b21pYygpIGRpcmVjdGx5IG9uY2UgaXQgbGFuZHMuCgpBbHNvLCBJIGZl
ZWwgdGhhdCBzb21ldGhpbmcgaXMgcXVpdGUgb2RkIHdpdGggbW0vZmlsZW1hcC5jLgpJdCBzaG91
bGRuJ3QgcmVxdWlyZSBldmVyeW9uZSB0byByZWludmVudCB0aGVpciBvd24gd29ya3F1ZXVlcywg
YXMgSQptZW50aW9uZWQgaGVyZSBbM10uIEkgYWxzbyBub3RpY2VkIHRoYXQgQWxleGFuZHJlIGlz
IGFkZGluZyBhIHdvcmtxdWV1ZQppbiBmaWxlbWFwLmNbNF0sIHdoaWNoIG1pZ2h0IGJlIGV4dGVu
ZGVkIHRvIGZpbGUgcGFnZSBjYWNoZSBoYW5kbGluZyBhcwp3ZWxsIGluIHRoZSBmdXR1cmUuCgpb
MV0gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxsLzIwMjYwNzMwLWJsay1kb250Y2FjaGUtdjct
MS0zZThlNjg1MDA2OGRAY29sdW1iaWEuZWR1LwpbMl0gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcv
YWxsLzg3ODdhMTc2LTZmNGItNDdmYy1hMzA5LTg2N2FjZjlmYmRmZkBrZXJuZWwuZGsvClszXSBo
dHRwczovL2xvcmUua2VybmVsLm9yZy9hbGwvQ0FHc0pfNHdVdkxvS0dhZlIzVS1qaTFrVVVhejZL
X1FkTjZReE1ULWFwU2FPNXRYcDBBQG1haWwuZ21haWwuY29tLwpbNF0gaHR0cHM6Ly9sb3JlLmtl
cm5lbC5vcmcvYWxsLzIwMjYwODE4MTYzMjIxLjU4OTM1Mi0zLWFsZXhAZ2hpdGkuZnIvCgpUaGFu
a3MKQmFycnkKCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
XwpMaW51eC1mMmZzLWRldmVsIG1haWxpbmcgbGlzdApMaW51eC1mMmZzLWRldmVsQGxpc3RzLnNv
dXJjZWZvcmdlLm5ldApodHRwczovL2xpc3RzLnNvdXJjZWZvcmdlLm5ldC9saXN0cy9saXN0aW5m
by9saW51eC1mMmZzLWRldmVsCg==
