Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C516C4167B
	for <linux-f2fs-devel@archiver.kernel.org>; Tue,  5 Dec 2023 14:34:55 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1rAWVg-0003Op-Gy;
	Tue, 05 Dec 2023 14:34:53 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <hsiangkao@linux.alibaba.com>) id 1rAWVf-0003Oi-3B
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 05 Dec 2023 14:34:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=u+Du7cucPLhbmuhTa+ORKwbIMMC4S+uCfwGtb55BFN4=; b=gtWbPSF+vcfffJgvgZD1Rz3h4C
 eA+3Uh3zbvMrZaB0hwUDBXRKEDyvsQ6D1w05+qpFCvkYLCKiWvKlfbE12pw5cvpaWiZwkhpP9Ui3R
 J/WWx1r7JLjaotN82fyLS7SvBqXm1PR/NGPhtZEyeeGl2JsXJfEI7ONNtORxBWSuxH/g=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=u+Du7cucPLhbmuhTa+ORKwbIMMC4S+uCfwGtb55BFN4=; b=TfSOSSP8KhOje5UI+xAKsYzgAi
 R9yEri0ZQLFfpS5EjcmW0/7R7cW7gedO8XaFGvbTxwN9xag4ZF44HO1/z9PiEQdxlDbgdAtQP1yNu
 1B8diTlh9VnTqIohtXPTH89Mki0k6TVWoaSo7lXAXJlmyBAt4VW+3DSp8ezfWImHCwVc=;
Received: from out30-118.freemail.mail.aliyun.com ([115.124.30.118])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1rAWVe-0006YJ-Ex for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 05 Dec 2023 14:34:51 +0000
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R231e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018046056;
 MF=hsiangkao@linux.alibaba.com; NM=1; PH=DS; RN=6; SR=0;
 TI=SMTPD_---0VxuuXco_1701786878; 
Received: from 30.27.65.35(mailfrom:hsiangkao@linux.alibaba.com
 fp:SMTPD_---0VxuuXco_1701786878) by smtp.aliyun-inc.com;
 Tue, 05 Dec 2023 22:34:40 +0800
Message-ID: <8597c64c-d26a-8073-9d00-b629bbb0ee33@linux.alibaba.com>
Date: Tue, 5 Dec 2023 22:34:37 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
To: Juhyung Park <qkrwngud825@gmail.com>
References: <CAD14+f2AVKf8Fa2OO1aAUdDNTDsVzzR6ctU_oJSmTyd6zSYR2Q@mail.gmail.com>
 <5a0e8b44-6feb-b489-cdea-e3be3811804a@linux.alibaba.com>
 <CAD14+f2G-buxTaWgb23DYW-HSd1sch6tJNKV2strt=toASZXQQ@mail.gmail.com>
 <649a3bc4-58bb-1dc8-85fb-a56e47b3d5c9@linux.alibaba.com>
 <CAD14+f1u6gnHLhGSoQxL9wLq9vDYse+Ac8zxep-O2E8hHreT2w@mail.gmail.com>
 <275f025d-e2f1-eaff-6af1-e909d370cee0@linux.alibaba.com>
 <CAD14+f3zgwgUugjnB7UGCYh4j3iXYsvv_DJ3yvwduA1xf3xn=A@mail.gmail.com>
 <d7c7ea8c-6e2f-e8d8-88c3-4952c506ed13@linux.alibaba.com>
 <CAD14+f2hPLv6RPZdYyi8q8SQGiBox2fYUaWwuBEjEbZKQdyU7g@mail.gmail.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <CAD14+f2hPLv6RPZdYyi8q8SQGiBox2fYUaWwuBEjEbZKQdyU7g@mail.gmail.com>
X-Headers-End: 1rAWVe-0006YJ-Ex
Subject: Re: [f2fs-dev] Weird EROFS data corruption
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
Cc: Yann Collet <yann.collet.73@gmail.com>, Gao Xiang <xiang@kernel.org>,
 linux-erofs@lists.ozlabs.org, linux-crypto@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

CgpPbiAyMDIzLzEyLzUgMjI6MjMsIEp1aHl1bmcgUGFyayB3cm90ZToKPiBIaSBHYW8sCj4gCj4g
T24gVHVlLCBEZWMgNSwgMjAyMyBhdCA0OjMy4oCvUE0gR2FvIFhpYW5nIDxoc2lhbmdrYW9AbGlu
dXguYWxpYmFiYS5jb20+IHdyb3RlOgo+Pgo+PiBIaSBKdWh5dW5nLAo+Pgo+PiBPbiAyMDIzLzEy
LzQgMTE6NDEsIEp1aHl1bmcgUGFyayB3cm90ZToKPj4KPj4gLi4uCj4+Pgo+Pj4+Cj4+Pj4gLSBD
b3VsZCB5b3Ugc2hhcmUgdGhlIGZ1bGwgbWVzc2FnZSBhYm91dCB0aGUgb3V0cHV0IG9mIGBsc2Nw
dWA/Cj4+Pgo+Pj4gU3VyZToKPj4+Cj4+PiBBcmNoaXRlY3R1cmU6ICAgICAgICAgICAgeDg2XzY0
Cj4+PiAgICAgQ1BVIG9wLW1vZGUocyk6ICAgICAgICAzMi1iaXQsIDY0LWJpdAo+Pj4gICAgIEFk
ZHJlc3Mgc2l6ZXM6ICAgICAgICAgMzkgYml0cyBwaHlzaWNhbCwgNDggYml0cyB2aXJ0dWFsCj4+
PiAgICAgQnl0ZSBPcmRlcjogICAgICAgICAgICBMaXR0bGUgRW5kaWFuCj4+PiBDUFUocyk6ICAg
ICAgICAgICAgICAgICAgOAo+Pj4gICAgIE9uLWxpbmUgQ1BVKHMpIGxpc3Q6ICAgMC03Cj4+PiBW
ZW5kb3IgSUQ6ICAgICAgICAgICAgICAgR2VudWluZUludGVsCj4+PiAgICAgQklPUyBWZW5kb3Ig
SUQ6ICAgICAgICBJbnRlbChSKSBDb3Jwb3JhdGlvbgo+Pj4gICAgIE1vZGVsIG5hbWU6ICAgICAg
ICAgICAgMTF0aCBHZW4gSW50ZWwoUikgQ29yZShUTSkgaTctMTE4NUc3IEAgMy4wMEdIego+Pj4g
ICAgICAgQklPUyBNb2RlbCBuYW1lOiAgICAgMTF0aCBHZW4gSW50ZWwoUikgQ29yZShUTSkgaTct
MTE4NUc3IEAgMy4wMEdIeiBOb25lIENQVQo+Pj4gICAgICAgICAgICAgICAgICAgICAgICAgICAg
IEAgMy4wR0h6Cj4+PiAgICAgICBCSU9TIENQVSBmYW1pbHk6ICAgICAxOTgKPj4+ICAgICAgIENQ
VSBmYW1pbHk6ICAgICAgICAgIDYKPj4+ICAgICAgIE1vZGVsOiAgICAgICAgICAgICAgIDE0MAo+
Pj4gICAgICAgVGhyZWFkKHMpIHBlciBjb3JlOiAgMgo+Pj4gICAgICAgQ29yZShzKSBwZXIgc29j
a2V0OiAgNAo+Pj4gICAgICAgU29ja2V0KHMpOiAgICAgICAgICAgMQo+Pj4gICAgICAgU3RlcHBp
bmc6ICAgICAgICAgICAgMQo+Pj4gICAgICAgQ1BVKHMpIHNjYWxpbmcgTUh6OiAgNjAlCj4+PiAg
ICAgICBDUFUgbWF4IE1IejogICAgICAgICA0ODAwLjAwMDAKPj4+ICAgICAgIENQVSBtaW4gTUh6
OiAgICAgICAgIDQwMC4wMDAwCj4+PiAgICAgICBCb2dvTUlQUzogICAgICAgICAgICA1OTkwLjQw
Cj4+PiAgICAgICBGbGFnczogICAgICAgICAgICAgICBmcHUgdm1lIGRlIHBzZSB0c2MgbXNyIHBh
ZSBtY2UgY3g4IGFwaWMgc2VwIG10cnIgcGdlIG1jCj4+PiAgICAgICAgICAgICAgICAgICAgICAg
ICAgICBhIGNtb3YgcGF0IHBzZTM2IGNsZmx1c2ggZHRzIGFjcGkgbW14IGZ4c3Igc3NlIHNzZTIg
c3MKPj4+ICAgICAgICAgICAgICAgICAgICAgICAgICAgIGh0IHRtIHBiZSBzeXNjYWxsIG54IHBk
cGUxZ2IgcmR0c2NwIGxtIGNvbnN0YW50X3RzYyBhcnQKPj4+ICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICBhcmNoX3BlcmZtb24gcGVicyBidHMgcmVwX2dvb2Qgbm9wbCB4dG9wb2xvZ3kgbm9u
c3RvcF8KPj4+ICAgICAgICAgICAgICAgICAgICAgICAgICAgIHRzYyBjcHVpZCBhcGVyZm1wZXJm
IHRzY19rbm93bl9mcmVxIHBuaSBwY2xtdWxxZHEgZHRlczYKPj4+ICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIDQgbW9uaXRvciBkc19jcGwgdm14IHNteCBlc3QgdG0yIHNzc2UzIHNkYmcgZm1h
IGN4MTYgeHQKPj4+ICAgICAgICAgICAgICAgICAgICAgICAgICAgIHByIHBkY20gcGNpZCBzc2U0
XzEgc3NlNF8yIHgyYXBpYyBtb3ZiZSBwb3BjbnQgdHNjX2RlYWQKPj4+ICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIGxpbmVfdGltZXIgYWVzIHhzYXZlIGF2eCBmMTZjIHJkcmFuZCBsYWhmX2xt
IGFibSAzZG5vd3AKPj4+ICAgICAgICAgICAgICAgICAgICAgICAgICAgIHJlZmV0Y2ggY3B1aWRf
ZmF1bHQgZXBiIGNhdF9sMiBjZHBfbDIgc3NiZCBpYnJzIGlicGIgc3QKPj4+ICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIGlicCBpYnJzX2VuaGFuY2VkIHRwcl9zaGFkb3cgZmxleHByaW9yaXR5
IGVwdCB2cGlkIGVwdF8KPj4+ICAgICAgICAgICAgICAgICAgICAgICAgICAgIGFkIGZzZ3NiYXNl
IHRzY19hZGp1c3QgYm1pMSBhdngyIHNtZXAgYm1pMiBlcm1zIGludnBjaWQKPj4+ICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICByZHRfYSBhdng1MTJmIGF2eDUxMmRxIHJkc2VlZCBhZHggc21h
cCBhdng1MTJpZm1hIGNsZmwKPj4+ICAgICAgICAgICAgICAgICAgICAgICAgICAgIHVzaG9wdCBj
bHdiIGludGVsX3B0IGF2eDUxMmNkIHNoYV9uaSBhdng1MTJidyBhdng1MTJ2bAo+Pj4gICAgICAg
ICAgICAgICAgICAgICAgICAgICAgeHNhdmVvcHQgeHNhdmVjIHhnZXRidjEgeHNhdmVzIHNwbGl0
X2xvY2tfZGV0ZWN0IGR0aGVybQo+Pj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgIGlkYSBh
cmF0IHBsbiBwdHMgaHdwIGh3cF9ub3RpZnkgaHdwX2FjdF93aW5kb3cgaHdwX2VwcAo+Pj4gICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIGh3cF9wa2dfcmVxIHZubWkgYXZ4NTEydmJtaSB1bWlw
IHBrdSBvc3BrZSBhdng1MTJfdmJtaQo+Pj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgMiBn
Zm5pIHZhZXMgdnBjbG11bHFkcSBhdng1MTJfdm5uaSBhdng1MTJfYml0YWxnIHRtZSBhdgo+Pj4g
ICAgICAgICAgICAgICAgICAgICAgICAgICAgeDUxMl92cG9wY250ZHEgcmRwaWQgbW92ZGlyaSBt
b3ZkaXI2NGIgZnNybSBhdng1MTJfdnAyaQo+Pgo+PiBTaWdoLCBJJ3ZlIGJlZW4gdGhpbmtpbmcu
ICBIZXJlIEZTUk0gaXMgdGhlIG1vc3Qgc2lnbmlmaWNhbnQgZGlmZmVyZW5jZSBiZXR3ZWVuCj4+
IG91ciBlbnZpcm9ubWVudHMsIGNvdWxkIHlvdSBvbmx5IHRyeSB0aGUgZm9sbG93aW5nIGRpZmYg
dG8gc2VlIGlmIHRoZXJlJ3MgYW55Cj4+IGRpZmZlcmVuY2UgYW55bW9yZT8gKHdpdGhvdXQgdGhl
IHByZXZpb3VzIGRpc2FibGUgcGF0Y2guKQo+Pgo+PiBkaWZmIC0tZ2l0IGEvYXJjaC94ODYvbGli
L21lbW1vdmVfNjQuUyBiL2FyY2gveDg2L2xpYi9tZW1tb3ZlXzY0LlMKPj4gaW5kZXggMWI2MGFl
ODFlY2Q4Li4xYjUyYTkxMzIzM2MgMTAwNjQ0Cj4+IC0tLSBhL2FyY2gveDg2L2xpYi9tZW1tb3Zl
XzY0LlMKPj4gKysrIGIvYXJjaC94ODYvbGliL21lbW1vdmVfNjQuUwo+PiBAQCAtNDEsOSArNDEs
NyBAQCBTWU1fRlVOQ19TVEFSVChfX21lbW1vdmUpCj4+ICAgICNkZWZpbmUgQ0hFQ0tfTEVOICAg
ICBjbXAgJDB4MjAsICVyZHg7IGpiIDFmCj4+ICAgICNkZWZpbmUgTUVNTU9WRV9CWVRFUyBtb3Zx
ICVyZHgsICVyY3g7IHJlcCBtb3ZzYjsgUkVUCj4+ICAgIC5MbWVtbW92ZV9iZWdpbl9mb3J3YXJk
Ogo+PiAtICAgICAgIEFMVEVSTkFUSVZFXzIgX19zdHJpbmdpZnkoQ0hFQ0tfTEVOKSwgXAo+PiAt
ICAgICAgICAgICAgICAgICAgICAgX19zdHJpbmdpZnkoQ0hFQ0tfTEVOOyBNRU1NT1ZFX0JZVEVT
KSwgWDg2X0ZFQVRVUkVfRVJNUywgXAo+PiAtICAgICAgICAgICAgICAgICAgICAgX19zdHJpbmdp
ZnkoTUVNTU9WRV9CWVRFUyksIFg4Nl9GRUFUVVJFX0ZTUk0KPj4gKyAgICAgICBDSEVDS19MRU4K
Pj4KPj4gICAgICAgICAgLyoKPj4gICAgICAgICAgICogbW92c3EgaW5zdHJ1Y3Rpb24gaGF2ZSBt
YW55IHN0YXJ0dXAgbGF0ZW5jeQo+IAo+IFl1cCwgdGhhdCBhbHNvIHNlZW1zIHRvIGZpeCBpdC4K
PiBBcmUgd2UgbG9va2luZyBhdCBhIHBvdGVudGlhbCBtZW1tb3ZlIGlzc3VlPwoKSSdtIHN0aWxs
IGFuYWx5emluZyB0aGlzIGJlaGF2aW9yIGFzIHdlbGwgYXMgdGhlIHJvb3QgY2F1c2UgYW5kCkkg
d2lsbCBhbHNvIHRyeSB0byBnZXQgYSByZWNlbnQgY2xvdWQgc2VydmVyIHdpdGggRlNSTSBteXNl
bGYKdG8gZmluZCBtb3JlIGNsdWVzLgoKVGhhbmtzLApHYW8gWGlhbmcKCgpfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpMaW51eC1mMmZzLWRldmVsIG1haWxp
bmcgbGlzdApMaW51eC1mMmZzLWRldmVsQGxpc3RzLnNvdXJjZWZvcmdlLm5ldApodHRwczovL2xp
c3RzLnNvdXJjZWZvcmdlLm5ldC9saXN0cy9saXN0aW5mby9saW51eC1mMmZzLWRldmVsCg==
