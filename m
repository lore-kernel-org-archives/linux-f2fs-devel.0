Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63F86CD5BB4
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 26 May 2026 05:38:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:To:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=k+/eIKZnhUXgTe4Ns2JwUR/wvd4J9+/jB1nBVy0JQqs=; b=IevOeS+OgLdIwIAsVv0j4hanHU
	oQTZziisqnAKjnSwt7J71rf13OE1XuYbW+pI6tg5NaX4hOLSD9ORSMYW3Q0OqugIn9lrbAjJ6rzqX
	1QdFBwWGTavZEiV9iYa0xpeI2xxuQFFsA0/lgTgR+u5g1o2c5kxxhib/0nZd8Ut/Pn9g=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wRkUu-0006Hn-8h;
	Tue, 26 May 2026 05:38:37 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <qwjhust@gmail.com>) id 1wRkUs-0006He-TY
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 26 May 2026 05:38:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:Cc:To:
 Subject:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=TKcL68H6zsfmpIhUFFnhw8x1utQVhAfQ7JmEHaAmBAM=; b=UFhhPFE4sqkN/qUE3wvwh+6wgY
 CaHLC+1H6ow31bu97RA4nY+GdH9+hDwBLjgAofuarf7Au4FM/D5jarMeqMfqNdHGk/yKLLnfVvc8Y
 KIZrG6xApLV/sHimvGzaSJf3geKR3VOPqBvKFclDlFzORGGgt+qSo/iuDXAu74xGDQd4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:Cc:To:Subject:Message-ID:Date:From
 :In-Reply-To:References:MIME-Version:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=TKcL68H6zsfmpIhUFFnhw8x1utQVhAfQ7JmEHaAmBAM=; b=ZQyMJnw4Vb4tstxARxlATIDofN
 FWsocZzSXbZft4G6kPLIOIecchfSuYc9+U6eAvIX65QK2j4bKF9jz1PIyQ4fxvwsJH6HX/HHXWC60
 nprLDU43JaI2LyG9VxiJbmfjXG/Yi/NLv3cZuX5lPXqlFiEFso3GLm1Q8jIu4/W1hLjo=;
Received: from mail-lj1-f175.google.com ([209.85.208.175])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wRkUs-0004pu-J6 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 26 May 2026 05:38:35 +0000
Received: by mail-lj1-f175.google.com with SMTP id
 38308e7fff4ca-39378db197aso105095761fa.3
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 25 May 2026 22:38:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779773903; cv=none;
 d=google.com; s=arc-20240605;
 b=CPis9q0MzgSYSsy/V9RBaAt/mtKeMJViCp6vzYA2bFrwZbHP1ykbpjw88+Tt7uSKtY
 ThPLEYRNSy3edJGE3NW08FlNza4s4y6DnI4pBZftc4Pz/zSDOpCAZQyYeUYNZoW1m/Uw
 0CCG/MDYt2Wv9XYLPxd4MlP1n5XppN7hcUTRn66ojq8T4JUxsm6W2i8BDOP/M3yYlBBJ
 K9Wgm7bxSwttXZqkqpp1MntymF463gacGHEEUywWLcor7WLanT5K6l4wB5y36zMKjecA
 8C8CUnm0UJhVvri8UI/Nwi/0t26bjsKMrtn816k9uk65eClwR5b9XUxP41/RKLZBC0Gk
 h2dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=TKcL68H6zsfmpIhUFFnhw8x1utQVhAfQ7JmEHaAmBAM=;
 fh=bJ9XQerAfHWhrHz9/U58eiEJKawwnkS72qVQDjih+Po=;
 b=i4+ZtsZL9ALEIMxtgy6m755rdWm75KEgL3FgJS574HwPdKOmtN2pWQ77YeUbRtoN9z
 IJTlm8kXW6ErJ4nJmae+EjgSb4X4fzLRNAZ54OOFW7Ij7nMacYjgsBAKpgqQZpVaT8+T
 cY7A1lEeF2y2FyfUPgU5E+cQx/sE/aP+jGXmQ68caltEHNmi5aYLZ5sEkytfsf1BPFVk
 MwNs510m157awCDi5nW2iM3dXKQB74dFASrtq07xTyihC2NA4gkXuAVco1q/jT8MPE3B
 3GIC2CZ2hrQrX6FQaExVTvIWuhcUheSSBXPMzj1x+Qo750cRaj/kTqPacFbDixer88f7
 rX7A==; darn=lists.sourceforge.net
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779773903; x=1780378703; darn=lists.sourceforge.net;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TKcL68H6zsfmpIhUFFnhw8x1utQVhAfQ7JmEHaAmBAM=;
 b=psUwnJu+k80U8yM1nGCKSZNaBYe3QQCPtnvHFTKlRmuq0/MFOz3yJI4GHE/6QPhgau
 123FRvCCyBu6tXf4y5bTcqYN9GdSe4DJ1vYhhY6CWezh9lJlg+aHChtXXydnrlOELIzb
 NUUHxvgKIQKEvGTjvj4chL0OVHeP3oJ6y9pucN2qf82mxgtg1WMuLSiO0X9pImyActcB
 zVRRjU2H/2cV8e9i+2+sPGSleMO7ObmYzC4z17Cu5zsY76L0cKq8BxPVqfFkNaHSDYIq
 LRX3kjUFh+5NXa40T6XjO/DxT/3w+MLUxvJm3Wu5HfWCujdy+I4U0yLkDoglUA6/aCFW
 9hDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779773903; x=1780378703;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=TKcL68H6zsfmpIhUFFnhw8x1utQVhAfQ7JmEHaAmBAM=;
 b=AaUnfgubhM8Q/bFyGm809ldn+JQYL/oQSI4YLB1vmAHollYBayBKjGxGBC5Z5JdGEE
 N+HD5YqkoaA+MDvF5if475TVgkmxQp+DVVWUCrS8qmvCHmP9ShfAnYdnVuastuF982tP
 RJSIXB11jkgm51jJYKtencg/xXdQ50LQJFugyTuTzDlu9iPtRcA9O67/YpiplE31RIra
 N8lN8MBKE9j35oig4sZU0llXvmEzU0MzubmrIXKRNis2sLnIm1Md4IBUdZzPoa52auq8
 vxnuvbN875fwsW+j1RH8DZe8heKi39lKkpob3Qx0crkifUPwQuC52DMf1/eUewljhQ9g
 qzcA==
X-Forwarded-Encrypted: i=1;
 AFNElJ8yAAcOufMf7VtvMHfjcTXzbIbU16L5EIoiECihlSl+U6QTh1id4vJQMbKqzTfTPx1RO9k3yTlzUSsomST1c8s1@lists.sourceforge.net
X-Gm-Message-State: AOJu0Yy/0b1GA1g3w4xwM3kqNI2eGFwaBFAuUN89cpzD5m+NsxLJhyvJ
 NVd+vSZQkREjqbpn/Q8o/OLwHDhE5emJyIWc8uPJZuSoTjhBT/yGWGhEeFBgIu0vBMNBRNi+sT/
 76V1qq/RMgwFw2KWv1rEAGPulmAdJ+zI=
X-Gm-Gg: Acq92OGErmK/EyIDd3YwPf/iEJVNe4/7Y0Wq1I0zWqVtKvWCcoJzgxuI5PrAHQY6bWg
 4+5TFUjoH5V8ErKE5qqfYxBFJy9O3GmVumstOg+1ODO1dFksZzj+q8vbC81D5U/OaKcdDolUZP6
 cnhhLXvVTArCRRn9iH2Bnjth7ta2AW4dLnIk55kJ1hq0Z7BW7nx2riQiLQPkkUHVIkp7yUtz+dP
 Ivp4CrTWXsitzYqWEsGl89q1DxsqDZLe47IyDbvjQzA1Sn6lmYA7GQpV+NYLMkx/7+rf8K5ejMp
 nC5oKBMFT8tei+yMuaI=
X-Received: by 2002:ac2:5586:0:b0:5a3:feed:31cc with SMTP id
 2adb3069b0e04-5aa3238e2e0mr3599974e87.24.1779773903168; Mon, 25 May 2026
 22:38:23 -0700 (PDT)
MIME-Version: 1.0
References: <20260525114621.571845-1-qiwenjie@xiaomi.com>
 <86c2f79d-ee26-4009-8051-82d25abf6d7b@kernel.org>
In-Reply-To: <86c2f79d-ee26-4009-8051-82d25abf6d7b@kernel.org>
From: Wenjie Qi <qwjhust@gmail.com>
Date: Tue, 26 May 2026 13:38:11 +0800
X-Gm-Features: AVHnY4JX8IJm-l3aedUm0QfKPEjRcVkn_eT7Qg-ABBiSwc6521hpVZSIhswM-RY
Message-ID: <CAGFpFsQimHFADZGKA2ezyz7eXRG1mMNFOFiJHbsQban_vjb5qQ@mail.gmail.com>
To: Chao Yu <chao@kernel.org>
X-Headers-End: 1wRkUs-0004pu-J6
Subject: Re: [f2fs-dev] [PATCH] f2fs: validate orphan inode entry count
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
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 qiwenjie@xiaomi.com, jaegeuk@kernel.org, stable@kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

QWdyZWVkLCBTQklfTkVFRF9GU0NLIG1heSBub3QgYmUgcGVyc2lzdGVkIGF0IHRoaXMgc3RhZ2Uu
CgogIEkgc2VudCB2MiB0byBhZGQgRVJST1JfSU5DT05TSVNURU5UX09SUEhBTiBhbmQgY2FsbCBm
MmZzX2hhbmRsZV9lcnJvcigpIG9uCiAgaW52YWxpZCBvcnBoYW4gZW50cnlfY291bnQsIHNvIHRo
ZSBjb3JydXB0aW9uIHJlYXNvbiBjYW4gYmUgcmVjb3JkZWQgaW4KICBzX2Vycm9yc1tdIGFzIGEg
cGVyc2lzdGVudCBoaW50IGZvciBmc2NrLgoKaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGludXgt
ZjJmcy1kZXZlbC8yMDI2MDUyNjA1MzU1Ny4xMDk2MjI5LTEtcWl3ZW5qaWVAeGlhb21pLmNvbS9U
LyN1CgpPbiBUdWUsIE1heSAyNiwgMjAyNiBhdCAxMDoxOeKAr0FNIENoYW8gWXUgPGNoYW9Aa2Vy
bmVsLm9yZz4gd3JvdGU6Cj4KPiBPbiA1LzI1LzI2IDE5OjQ2LCBXZW5qaWUgUWkgd3JvdGU6Cj4g
PiBmMmZzX3JlY292ZXJfb3JwaGFuX2lub2RlcygpIHRydXN0cyB0aGUgb3JwaGFuIGJsb2NrIGVu
dHJ5X2NvdW50IHdoZW4KPiA+IHJlcGxheWluZyBvcnBoYW4gaW5vZGVzIGZyb20gdGhlIGNoZWNr
cG9pbnQgcGFjay4gIEEgY29ycnVwdGVkCj4gPiBlbnRyeV9jb3VudCBsYXJnZXIgdGhhbiBGMkZT
X09SUEhBTlNfUEVSX0JMT0NLIG1ha2VzIHRoZSByZWNvdmVyeSBsb29wCj4gPiByZWFkIHBhc3Qg
dGhlIGlub1tdIGFycmF5IGFuZCBpbnRlcnByZXQgZm9vdGVyIG9yIGZvbGxvd2luZyBkYXRhIGFz
Cj4gPiBpbm9kZSBudW1iZXJzLgo+ID4KPiA+IE9uIGEgY3JhZnRlZCBpbWFnZSwgbW91bnRpbmcg
YW4gdW5wYXRjaGVkIGtlcm5lbCBjYW4gZHJpdmUgb3JwaGFuCj4gPiByZWNvdmVyeSBpbnRvIGYy
ZnNfYnVnX29uKCkgYW5kIHBhbmljIHRoZSBrZXJuZWwuICBWYWxpZGF0ZSBlbnRyeV9jb3VudAo+
ID4gYmVmb3JlIGNvbnN1bWluZyBlbnRyaWVzIHNvIGNvcnJ1cHRlZCBjaGVja3BvaW50IGRhdGEg
ZmFpbHMgdGhlIG1vdW50Cj4gPiB3aXRoIC1FRlNDT1JSVVBURUQgYW5kIHJlcXVlc3RzIGZzY2sg
aW5zdGVhZC4KPiA+Cj4gPiBGaXhlczogMTI3ZTY3MGFiZmE3ICgiZjJmczogYWRkIGNoZWNrcG9p
bnQgb3BlcmF0aW9ucyIpCj4gPiBDYzogc3RhYmxlQGtlcm5lbC5vcmcKPiA+IFNpZ25lZC1vZmYt
Ynk6IFdlbmppZSBRaSA8cWl3ZW5qaWVAeGlhb21pLmNvbT4KPiA+IC0tLQo+ID4gIGZzL2YyZnMv
Y2hlY2twb2ludC5jIHwgMTMgKysrKysrKysrKysrLQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAxMiBp
bnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pCj4gPgo+ID4gZGlmZiAtLWdpdCBhL2ZzL2YyZnMv
Y2hlY2twb2ludC5jIGIvZnMvZjJmcy9jaGVja3BvaW50LmMKPiA+IGluZGV4IGMwMGE2YjZlYmNi
ZC4uZmM3MmI2OWZmNzY5IDEwMDY0NAo+ID4gLS0tIGEvZnMvZjJmcy9jaGVja3BvaW50LmMKPiA+
ICsrKyBiL2ZzL2YyZnMvY2hlY2twb2ludC5jCj4gPiBAQCAtOTQzLDYgKzk0Myw3IEBAIGludCBm
MmZzX3JlY292ZXJfb3JwaGFuX2lub2RlcyhzdHJ1Y3QgZjJmc19zYl9pbmZvICpzYmkpCj4gPiAg
ICAgICBmb3IgKGkgPSAwOyBpIDwgb3JwaGFuX2Jsb2NrczsgaSsrKSB7Cj4gPiAgICAgICAgICAg
ICAgIHN0cnVjdCBmb2xpbyAqZm9saW87Cj4gPiAgICAgICAgICAgICAgIHN0cnVjdCBmMmZzX29y
cGhhbl9ibG9jayAqb3JwaGFuX2JsazsKPiA+ICsgICAgICAgICAgICAgdW5zaWduZWQgaW50IGVu
dHJ5X2NvdW50Owo+ID4KPiA+ICAgICAgICAgICAgICAgZm9saW8gPSBmMmZzX2dldF9tZXRhX2Zv
bGlvKHNiaSwgc3RhcnRfYmxrICsgaSk7Cj4gPiAgICAgICAgICAgICAgIGlmIChJU19FUlIoZm9s
aW8pKSB7Cj4gPiBAQCAtOTUxLDcgKzk1MiwxNyBAQCBpbnQgZjJmc19yZWNvdmVyX29ycGhhbl9p
bm9kZXMoc3RydWN0IGYyZnNfc2JfaW5mbyAqc2JpKQo+ID4gICAgICAgICAgICAgICB9Cj4gPgo+
ID4gICAgICAgICAgICAgICBvcnBoYW5fYmxrID0gZm9saW9fYWRkcmVzcyhmb2xpbyk7Cj4gPiAt
ICAgICAgICAgICAgIGZvciAoaiA9IDA7IGogPCBsZTMyX3RvX2NwdShvcnBoYW5fYmxrLT5lbnRy
eV9jb3VudCk7IGorKykgewo+ID4gKyAgICAgICAgICAgICBlbnRyeV9jb3VudCA9IGxlMzJfdG9f
Y3B1KG9ycGhhbl9ibGstPmVudHJ5X2NvdW50KTsKPiA+ICsgICAgICAgICAgICAgaWYgKGVudHJ5
X2NvdW50ID4gRjJGU19PUlBIQU5TX1BFUl9CTE9DSykgewo+ID4gKyAgICAgICAgICAgICAgICAg
ICAgIGYyZnNfZXJyKHNiaSwgImludmFsaWQgb3JwaGFuIGlub2RlIGVudHJ5IGNvdW50ICV1IiwK
PiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBlbnRyeV9jb3VudCk7Cj4gPiArICAg
ICAgICAgICAgICAgICAgICAgc2V0X3NiaV9mbGFnKHNiaSwgU0JJX05FRURfRlNDSyk7Cj4KPiBX
ZWxsLCBhdCB0aGlzIHN0YWdlLCBJIGd1ZXNzIHRoZXJlIGlzIG5vIGNoYW5jZSB0byBwZXJzaXN0
IFNCSV9ORUVEX0ZTQ0sgZmxhZywKPiB3aGF0IGFib3V0IGludHJvZHVjZSBFUlJPUl9JTkNPTlNJ
U1RFTlRfT1JQSEFOIGluIGVudW0gZjJmc19lcnJvciwgc28gdGhhdAo+IHdlIGNhbiBwZXJzaXN0
IHRoZSBuZXcgYml0IHRvIHByb3ZpZGUgaGludCB0byBmc2NrPwo+Cj4gVGhhbmtzLAo+Cj4gPiAr
ICAgICAgICAgICAgICAgICAgICAgZXJyID0gLUVGU0NPUlJVUFRFRDsKPiA+ICsgICAgICAgICAg
ICAgICAgICAgICBmMmZzX2ZvbGlvX3B1dChmb2xpbywgdHJ1ZSk7Cj4gPiArICAgICAgICAgICAg
ICAgICAgICAgZ290byBvdXQ7Cj4gPiArICAgICAgICAgICAgIH0KPiA+ICsKPiA+ICsgICAgICAg
ICAgICAgZm9yIChqID0gMDsgaiA8IGVudHJ5X2NvdW50OyBqKyspIHsKPiA+ICAgICAgICAgICAg
ICAgICAgICAgICBuaWRfdCBpbm8gPSBsZTMyX3RvX2NwdShvcnBoYW5fYmxrLT5pbm9bal0pOwo+
ID4KPiA+ICAgICAgICAgICAgICAgICAgICAgICBlcnIgPSByZWNvdmVyX29ycGhhbl9pbm9kZShz
YmksIGlubyk7Cj4KCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fXwpMaW51eC1mMmZzLWRldmVsIG1haWxpbmcgbGlzdApMaW51eC1mMmZzLWRldmVsQGxpc3Rz
LnNvdXJjZWZvcmdlLm5ldApodHRwczovL2xpc3RzLnNvdXJjZWZvcmdlLm5ldC9saXN0cy9saXN0
aW5mby9saW51eC1mMmZzLWRldmVsCg==
