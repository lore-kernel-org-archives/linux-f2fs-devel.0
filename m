Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B3A6C5320E
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 22 Aug 2024 10:59:15 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1sh5X7-0006cE-Pk;
	Thu, 22 Aug 2024 10:59:13 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <quwenruo.btrfs@gmx.com>) id 1sh5X6-0006c3-85
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 22 Aug 2024 10:59:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=z7bsh2q22Pgsp59libq4MfKgK1dNZBn4pNAk8Le00aA=; b=Y4Szc67V7mZr+qT3d/PcP8q+vy
 +fi3AWxzLr0tH559N2ApAsqh048vzZfQgmbzLFGeNHLEIVBChzvxo0QaeYAuGglIivEJyZnGBSVAq
 iyCAyra37zF14yuxHTACXSBgLUYnvkXBefFUaoihyq9CGUwO2JMriSwKbWAqjC6gt9+c=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=z7bsh2q22Pgsp59libq4MfKgK1dNZBn4pNAk8Le00aA=; b=Bc/TprCegJxkaq+2gY62AJeBWY
 KQT/14G0SBr2YYm0OGGbHDGtk6hInRXaflmAxbFfAYTGa0Go7Q7rghNI1cbU0f8SIDTPD1or2zF/6
 ageXMXDc0gub0Ny9gdRttK0+rje/pWgEinRytRMYUcyTfuUBmsNd4Iven8RO8Ggy2H8o=;
Received: from mout.gmx.net ([212.227.17.21])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1sh5X5-0007nF-3s for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 22 Aug 2024 10:59:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
 s=s31663417; t=1724324297; x=1724929097; i=quwenruo.btrfs@gmx.com;
 bh=z7bsh2q22Pgsp59libq4MfKgK1dNZBn4pNAk8Le00aA=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=KaogCv3KJROMprj1/OqnmP91/56PhqjfDJshEDdSa+47ut3lmYAGaarB6wtpCJ1R
 es+ChW2fcHtdXE+wJkSzelimtg9nFOX6kqwrV4sIyiwILtuAfkJPoKe5+2vqTNqq5
 kPyr3f26GTcQrTWcQaMTLm2SMfcIPIamKsljVHzsd4jX6R5xMMMYyCzkRFezYaBzL
 3ZUQdN87o2G4+jLzBSLOpVV4JU3+ZitT4snnxWyPCb7rkIUnXt7ZRxGm/CObKQXTL
 BIQtwFmIJVHVqOjDtxPuS6aBV4s2GR7IH0Xez3GJ0f8E1SfItk3xe8j8H7EVC34ue
 7Q/JJJeqOomFroVwXQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Mkpex-1sH8Ip2yid-00jpL5; Thu, 22
 Aug 2024 12:58:17 +0200
Message-ID: <0f643b0f-f1c2-48b7-99d5-809b8b7f0aac@gmx.com>
Date: Thu, 22 Aug 2024 20:28:09 +0930
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Matthew Wilcox <willy@infradead.org>, Li Zetao <lizetao1@huawei.com>
References: <20240822013714.3278193-1-lizetao1@huawei.com>
 <20240822013714.3278193-3-lizetao1@huawei.com>
 <Zsaq_QkyQIhGsvTj@casper.infradead.org>
Content-Language: en-US
Autocrypt: addr=quwenruo.btrfs@gmx.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNIlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT7CwJQEEwEIAD4CGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCY00iVQUJDToH
 pgAKCRDCPZHzoSX+qNKACACkjDLzCvcFuDlgqCiS4ajHAo6twGra3uGgY2klo3S4JespWifr
 BLPPak74oOShqNZ8yWzB1Bkz1u93Ifx3c3H0r2vLWrImoP5eQdymVqMWmDAq+sV1Koyt8gXQ
 XPD2jQCrfR9nUuV1F3Z4Lgo+6I5LjuXBVEayFdz/VYK63+YLEAlSowCF72Lkz06TmaI0XMyj
 jgRNGM2MRgfxbprCcsgUypaDfmhY2nrhIzPUICURfp9t/65+/PLlV4nYs+DtSwPyNjkPX72+
 LdyIdY+BqS8cZbPG5spCyJIlZonADojLDYQq4QnufARU51zyVjzTXMg5gAttDZwTH+8LbNI4
 mm2YzsBNBFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcga
 CbPEwhLj1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj
 /IrRUUka68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fN
 GSsRb+pKEKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0
 q1eW4Jrv0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEv
 ABEBAAHCwHwEGAEIACYCGwwWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCY00ibgUJDToHvwAK
 CRDCPZHzoSX+qK6vB/9yyZlsS+ijtsvwYDjGA2WhVhN07Xa5SBBvGCAycyGGzSMkOJcOtUUf
 tD+ADyrLbLuVSfRN1ke738UojphwkSFj4t9scG5A+U8GgOZtrlYOsY2+cG3R5vjoXUgXMP37
 INfWh0KbJodf0G48xouesn08cbfUdlphSMXujCA8y5TcNyRuNv2q5Nizl8sKhUZzh4BascoK
 DChBuznBsucCTAGrwPgG4/ul6HnWE8DipMKvkV9ob1xJS2W4WJRPp6QdVrBWJ9cCdtpR6GbL
 iQi22uZXoSPv/0oUrGU+U5X4IvdnvT+8viPzszL5wXswJZfqfy8tmHM85yjObVdIG6AlnrrD
In-Reply-To: <Zsaq_QkyQIhGsvTj@casper.infradead.org>
X-Provags-ID: V03:K1:7mJ/c2TSUe7ALlg/F/jsxHMl5yUnUZOzvtsePpbl8j9Tgi8Z+Uc
 RdKVWi4eOMccC0EPginzcTHe6Ga93ofgbjmOaEBSGEY+zvWLpVGPl26soN+dq420p4tPpRc
 4cq2al3tap77XWwR2+bWUr/r2Nqowd3hRrg27djBftxTKFTb2U0COGa73wjaE0K1du4DHOk
 KLaO3oFCjUYzQOSpFVMrA==
UI-OutboundReport: notjunk:1;M01:P0:WQ2j5eHUrqg=;lzfUnnLzgJ/gd/5x9OeFiO3zLn6
 3eOeHmD4TtIMkS+Psz9XyNUWsUcCEfAvYkDrWsBFjPRgNBU1kHUNtJOhl2E4MhoeCDWvBgXfP
 nkdR3oB6JNpYwiJgMXTwQKy/nbZ/EnUMToQQnulSxXU8PqQFFrV17WzfYIAXQlOQigLhfLh+G
 bv1MP4c9u5BPtYEBEeO/VMsijST3jywKnhGAwEjDNxHRf4cPRYbzBMkhm8fOfMXHaG+uaJEEF
 nFmMD33QUe/PsYSSTzA272r1cJxoAiONYvHeeOjOJnaezvsGmQYRcoPHOwRRmrt59oC7YPB8B
 Yorg3LTQH5vjDt+iHzonUcjZhWodUNkPe9qEL3wvTfxrLc9m9TmODaHMEnD6r/Of0Xz01KJOh
 EBykOPt5iLadJzHS9+wj95hb4De10z72yqi1zztTK7VczeZqoamAcLnLM1wJRL4DuwCdPMLoP
 o6hRhDfhtIA3OAzCSNNe2FxGJwEohieFlnWOv0Or9BUF0bnpnIQzXP7+8Y5lpAk+v4d/NqADV
 7seRQwtOAAzY695k4ejXSb9yxgnCAIr4dA+M55KuoGEa0SYstY6qkEJp48rM3vDNfd8kYw9st
 cTF/JKUaxGs729yKaWbrDIRHBbXIr94RTIBV8ZKNIk6qNy/e5CcomOpcAcjnYgjm9q9NgQ3TK
 p14rBY2evekgqPz2PV1E7HTkEEJT/tOSF72Yw25wsi6L8AcWJSxASMbQWF/xfHbrvTnojM0PE
 6AbZM0mNu2DHZsfDgTUzpBSMg9/BwkH50hYXLCFRguz/Hl1LYpc0EOPdJdyMS0IWymjAG4nno
 sc4vuswZYMDpvKmD3sn0f4NQ==
X-Headers-End: 1sh5X5-0007nF-3s
Subject: Re: [f2fs-dev] [PATCH 02/14] btrfs: convert
 get_next_extent_buffer() to take a folio
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
From: Qu Wenruo via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: josef@toxicpanda.com, linux-f2fs-devel@lists.sourceforge.net, clm@fb.com,
 terrelln@fb.com, dsterba@suse.com, linux-btrfs@vger.kernel.org
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

CgrlnKggMjAyNC84LzIyIDEyOjM1LCBNYXR0aGV3IFdpbGNveCDlhpnpgZM6Cj4gT24gVGh1LCBB
dWcgMjIsIDIwMjQgYXQgMDk6Mzc6MDJBTSArMDgwMCwgTGkgWmV0YW8gd3JvdGU6Cj4+ICAgc3Rh
dGljIHN0cnVjdCBleHRlbnRfYnVmZmVyICpnZXRfbmV4dF9leHRlbnRfYnVmZmVyKAo+PiAtCQlj
b25zdCBzdHJ1Y3QgYnRyZnNfZnNfaW5mbyAqZnNfaW5mbywgc3RydWN0IHBhZ2UgKnBhZ2UsIHU2
NCBieXRlbnIpCj4+ICsJCWNvbnN0IHN0cnVjdCBidHJmc19mc19pbmZvICpmc19pbmZvLCBzdHJ1
Y3QgZm9saW8gKmZvbGlvLCB1NjQgYnl0ZW5yKQo+PiAgIHsKPj4gICAJc3RydWN0IGV4dGVudF9i
dWZmZXIgKmdhbmdbR0FOR19MT09LVVBfU0laRV07Cj4+ICAgCXN0cnVjdCBleHRlbnRfYnVmZmVy
ICpmb3VuZCA9IE5VTEw7Cj4+IC0JdTY0IHBhZ2Vfc3RhcnQgPSBwYWdlX29mZnNldChwYWdlKTsK
Pj4gLQl1NjQgY3VyID0gcGFnZV9zdGFydDsKPj4gKwl1NjQgZm9saW9fc3RhcnQgPSBmb2xpb19w
b3MoZm9saW8pOwo+PiArCXU2NCBjdXIgPSBmb2xpb19zdGFydDsKPj4KPj4gLQlBU1NFUlQoaW5f
cmFuZ2UoYnl0ZW5yLCBwYWdlX3N0YXJ0LCBQQUdFX1NJWkUpKTsKPj4gKwlBU1NFUlQoaW5fcmFu
Z2UoYnl0ZW5yLCBmb2xpb19zdGFydCwgUEFHRV9TSVpFKSk7Cj4+ICAgCWxvY2tkZXBfYXNzZXJ0
X2hlbGQoJmZzX2luZm8tPmJ1ZmZlcl9sb2NrKTsKPj4KPj4gLQl3aGlsZSAoY3VyIDwgcGFnZV9z
dGFydCArIFBBR0VfU0laRSkgewo+PiArCXdoaWxlIChjdXIgPCBmb2xpb19zdGFydCArIFBBR0Vf
U0laRSkgewo+Cj4gUHJlc3VtYWJseSB3ZSB3YW50IHRvIHN1cHBvcnQgbGFyZ2UgZm9saW9zIGlu
IGJ0cmZzIGF0IHNvbWUgcG9pbnQ/CgpZZXMsIGFuZCB3ZSdyZSBhbHJlYWR5IHdvcmtpbmcgdG93
YXJkcyB0aGF0IGRpcmVjdGlvbi4KCj4gSSBjZXJ0YWlubHkgd2FudCB0byByZW1vdmUgQ09ORklH
X1JFQURfT05MWV9USFBfRk9SX0ZTIHNvb24gYW5kIHRoYXQnbGwKPiBiZSBhIGJpdCBvZiBhIHJl
Z3Jlc3Npb24gZm9yIGJ0cmZzIGlmIGl0IGRvZXNuJ3QgaGF2ZSBsYXJnZSBmb2xpbwo+IHN1cHBv
cnQuICBTbyBzaG91bGRuJ3Qgd2UgYWxzbyBzL1BBR0VfU0laRS9mb2xpb19zaXplKGZvbGlvKS8g
PwoKQUZBSUsgd2UncmUgb25seSBnb2luZyB0byBzdXBwb3J0IGxhcmdlciBmb2xpb3MgdG8gc3Vw
cG9ydCBsYXJnZXIgdGhhbgpQQUdFX1NJWkUgc2VjdG9yIHNpemUgc28gZmFyLgpTbyBldmVyeSBm
b2xpbyBpcyBzdGlsbCBpbiBhIGZpeGVkIHNpemUgKHNlY3RvciBzaXplLCA+PSBQQUdFX1NJWkUp
LgoKTm90IGZhbWlsaWFyIHdpdGggdHJhbnNwYXJlbnQgaHVnZSBwYWdlLCBJIHRob3VnaHQgdHJh
bnNwYXJlbnQgaHVnZSBwYWdlCmlzIHRyYW5zcGFyZW50IHRvIGZzLgoKT3IgZG8gd2UgbmVlZCBz
b21lIHNwZWNpYWwgaGFuZGxpbmc/Ck15IHVuZWR1Y2F0ZWQgZ3Vlc3MgaXMsIHdlIHdpbGwgZ2V0
IGEgbGFyZ2VyIGZvbGlvIHBhc3NlZCB0byByZWFkcGFnZQpjYWxsIGJhY2sgZGlyZWN0bHk/Ckl0
J3Mgc3RyYWlnaHRmb3J3YXJkIGVub3VnaCB0byByZWFkIGFsbCBjb250ZW50cyBmb3IgYSBsYXJn
ZXIgZm9saW8sCml0J3Mgbm8gZGlmZmVyZW50IHRvIHN1YnBhZ2UgaGFuZGxpbmcuCgpCdXQgd2hh
dCB3aWxsIGhhcHBlbiBpZiBzb21lIHdyaXRlcyBoYXBwZW5lZCB0byB0aGF0IGxhcmdlciBmb2xp
bz8KRG8gTU0gbGF5ZXIgZGV0ZWN0cyB0aGF0IGFuZCBzcGxpdCB0aGUgZm9saW9zPyBPciB0aGUg
ZnMgaGFzIHRvIGdvIHRoZQpzdWJwYWdlIHJvdXRpbmUgKHdpdGggYW4gZXh0cmEgc3RydWN0dXJl
IHJlY29yZGluZyBhbGwgdGhlIHN1YnBhZ2UgZmxhZ3MKYml0bWFwKT8KClRoYW5rcywKUXUKCgpf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpMaW51eC1mMmZz
LWRldmVsIG1haWxpbmcgbGlzdApMaW51eC1mMmZzLWRldmVsQGxpc3RzLnNvdXJjZWZvcmdlLm5l
dApodHRwczovL2xpc3RzLnNvdXJjZWZvcmdlLm5ldC9saXN0cy9saXN0aW5mby9saW51eC1mMmZz
LWRldmVsCg==
