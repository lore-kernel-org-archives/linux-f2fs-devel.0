Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2194DC88E66
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 14 Sep 2026 09:35:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:To:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Yyupz4m339bWukSvhLUWqLo5C5YQtvsV/nD8be+l6o0=; b=NYt8dcOQe3qSL5N0Wp+o4vb7Iq
	D8BoJDIS5kbJJD650WfW/QDU5Z2yUBq8fD4QWOIjdNv9ViONvtTYx+msg3UFXs/xGMlmZ9cMwD/+T
	dLPVBhSXpaVeCNcXVrYjdt0cdmFbmCa30hDu2jBiQmOxS2mQBxvIQWvzvsCbay/Tb4QI=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1x636Q-0003LM-Mo;
	Mon, 14 Sep 2026 09:35:55 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <niuzhiguo84@gmail.com>) id 1x636P-0003LG-TR
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 14 Sep 2026 09:35:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:Cc:To:
 Subject:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=KPbxA0COvaPTjnPAWf2N63szWFNsCTQ4JdCXnPgmE9c=; b=JXXezfYmbT9Pwq7O88AFPWKto0
 qNxerW3uNtDd6fMbol/cvuEnNjjNJ2mEASB8DfgjgjWpOl89W0zekNXrzWdaksVTGXiyyvKNtqADq
 DRhtyPbI4BcgHDTYGcRUee8ul+LckSV6ODAN+t5m7+gWTDhUktIVLBO4UBo4btNeJ1ic=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:Cc:To:Subject:Message-ID:Date:From
 :In-Reply-To:References:MIME-Version:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=KPbxA0COvaPTjnPAWf2N63szWFNsCTQ4JdCXnPgmE9c=; b=YZf5EtM6NlJtfcr1StliGRSmBq
 Ixl0ZgCYNRbHRikUDXOYeZNoWXaJ8ii/9qe/OjfrcCDZLTP0jdmpsvX0AVrH4fG4dpCkvHsiSnj3y
 74Y+XqMayFjYRpDCcKYcK/m2aGDNqr5W6EM5QhprcnsDB+EPYRwgIJljn1pbRMHpB/rM=;
Received: from mail-wr2-f12.google.com ([74.125.225.76])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x636M-0002b8-MH for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 14 Sep 2026 09:35:54 +0000
Received: by mail-wr2-f12.google.com with SMTP id
 ffacd0b85a97d-48435ae9ca4so240086f8f.3
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 14 Sep 2026 02:35:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789378544; cv=none;
 d=google.com; s=arc-20260327;
 b=HtW4hWsxaNHM82dpohzhVpqSzorJ8IPhRkwI/O5Q9me3OdglaiVr4SogThQEW6btEZ
 HslCDlZbZaQVlHzwDeoZcMJIFxuX5XZXfx09qh/JYtrweM0iEqom4V4s3/69R+DbBbUd
 BMOV8UHu7mTkQM+d5+h6gbjSCO7zc307M1T5qOHKfh1pZTd2/UwgiJj7s3vTvWZ3jLxU
 lYVyl0Bgz1Wf1srmOIJXfUwp752dzVF+bWtxnIPfJS7Vs2WYBtilI0Y1PizfUuannSMZ
 1MGwfJdXtYcfZZub+m74MoCV7HNmZVl+oNHr/94t3YKhcMWTpYFLY/UO7tDlhEq+e1SQ
 E/WA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=KPbxA0COvaPTjnPAWf2N63szWFNsCTQ4JdCXnPgmE9c=;
 fh=jIjCHijOA3aeuqbuoJ/hipGXGOWRM/+M+Ehl2r4tfMg=;
 b=FC0KAKECevGMJgOHZZqmxZNrYyeytoJPoqrGhVFi3De00aijgDemho4BNpB+HkkD4o
 QtU+pJplU23EsUpSqU0bXkusJEC2T/IGhnbQ6a7kt2+9h/A7AltmtjmaZJL33FsCKo0y
 5BM43RNNqDEFMBvx0e163s6w28OinTWMmHbLDTWEiMAPw8haGTbs7nQJP0mPz2gGrR/i
 fPdudl0sf1zgS//wQ4x1IeIGRD1tkUsQNfjjJy773sQasj4MhCX71C3obL9qAXNj7fVJ
 uwQ9ZozBMpJxqRz0T5aroFjyhNbTMMreOUUliQcL+Yl/7fdkwhgzSUklPOIhGdafOzsW
 O7kw==; darn=lists.sourceforge.net
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789378544; x=1789983344; darn=lists.sourceforge.net;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=KPbxA0COvaPTjnPAWf2N63szWFNsCTQ4JdCXnPgmE9c=;
 b=hrTGsNG/G4q85VGoB86KyvpW21XzxVhvmdLIEXdlCgXxJDwQC6qwoO9riptd58GVcl
 KtsVIoMJAaCmobWYce54j+vO3/iFJWker5fW1wNS9mJrjDIygRq7ObOa9NyLlE9CC9R3
 sq23M7aNEQC6GWTFGv3dTmPqdMoCqgVHZVC5DDHZ400RbZhUDANiD3NM5Qqu5OYuQYeT
 SQiJmPZLyTG7aZ3X7PD7G0E6Mad93jaXuXwoduHOEZqz54jb5NdG/qAltkazmL/2+IfU
 uyZJ8IEMTAwp3GfKBDyFK5sIPl+O3XKFfEToKD6wMtbGoHEYI2d8mxK29ue0N06avnbJ
 kOlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789378544; x=1789983344;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=KPbxA0COvaPTjnPAWf2N63szWFNsCTQ4JdCXnPgmE9c=;
 b=JSWVaOvfDKyKFV4O++409gHqXtGoKMrBbA3/S8r5zAhFiZfa1bEIT+WvqchDS9BciA
 I0+rpsoa1t5+4yOlSVaGqkNB00LQlrgAbmCIP5IZxWcxdwOs8oUH7RjU9BoHVyC8cCiV
 VfTnpR0ZSALmbSW2UhnTH9vrne/h03/xBw/lwdt41rilFhZwAOxEFPb8CbPgZkylLCeb
 1r8/g2XxEJKkBhkLaQvKBZK+Fb7CZH99j13qUYO+b7x0+xIaGw9xRbCWnnOSXYml6emp
 wfcWIK/pGL7K6UNOg5dbxHtq3894Ji11XbNy7OlLbcMGdMe25ovMKIs/Pgk4VMwNrgkV
 esDg==
X-Forwarded-Encrypted: i=1;
 AKwUvBxcp4/MrSI8HRBPyvpLLc/EuV+K8xIfoYgtOXDoQjw80KuThj+J+w7i0w/ZVunkiZQrl7x17dcEEYn13e4va2Gw@lists.sourceforge.net
X-Gm-Message-State: AFuF++mueEU4dzweVIdHI7cfm0pSAdngiFlTap0HmP1CygqZRtE69bUX
 mzkiVde1vvFyZm0kOicpcPsCgRN4+oDHUs6xh3VXYl34IIbguPuWPNKZZ32tp18apvmt63kfuGF
 xWatSy7mpUClP7/n7Nmzu8kNX2aoYLVsBb/8+
X-Gm-Gg: AYBFou07VoL1XU3GRvCudQFRFOo5G2baflM/FHeVe4KMiN6mppqlOq/Bp56D2xTFqPQ
 fhbVQ6n/ko1NrKjr6WvMnZZyr0Eyr0SUolUYs/hLiYTAYJJtNPimtv9ZXxfu/Zt4y8UkWcwZOp3
 O3ytN/EgZ23w93MhK+wNUBOcDeE/9SNpRkPwYgn6BiwM56JUENKRVRJeD6v0ceWzMG0LOYL8Ohx
 vFmg4p149WS3tcEbvjuOjUrzxHWgr4NkYUb7ivO+tsFbkkqohI/elpdC0Sg0ZCplkohNPhr2Xue
 xHYSuv4aTbC7vju4rSTtIr2Y/WJ83rQBTzY1ubnrJkv+9vZ7oXXP3fMx
X-Received: by 2002:a05:600c:3b9f:b0:49e:745d:5768 with SMTP id
 5b1f17b1804b1-49e7a5f1f60mr23605915e9.0.1789378544021; Mon, 14 Sep 2026
 02:35:44 -0700 (PDT)
MIME-Version: 1.0
References: <20260911232405.1815804-1-chao@kernel.org>
 <20260911232405.1815804-11-chao@kernel.org>
In-Reply-To: <20260911232405.1815804-11-chao@kernel.org>
From: Zhiguo Niu <niuzhiguo84@gmail.com>
Date: Mon, 14 Sep 2026 17:35:32 +0800
X-Gm-Features: AcwNN1VnSCWJgpKtwXQyP1wTpU6veJ78avoYFHwQRsO6Xvdy_W_Jkqe4MFswL-o
Message-ID: <CAHJ8P3+cDHYmS22Jj4Za1=9bHEDQzsDYP=uBvDHT3ZyAizYZXA@mail.gmail.com>
To: Chao Yu <chao@kernel.org>
X-Headers-End: 1x636M-0002b8-MH
Subject: Re: [f2fs-dev] [PATCH v7 10/12] f2fs: cache: support fault injection
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
Cc: jaegeuk@kernel.org, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Q2hhbyBZdSB2aWEgTGludXgtZjJmcy1kZXZlbCA8bGludXgtZjJmcy1kZXZlbEBsaXN0cy5zb3Vy
Y2Vmb3JnZS5uZXQ+CuS6jjIwMjblubQ55pyIMTLml6Xlkajlha0gMDc6MjjlhpnpgZPvvJoKPgo+
IEZyb206IENoYW8gWXUgPGNoYW9Aa2VybmVsLm9yZz4KPgo+IFRoaXMgcGF0Y2ggYWRkcyBmYXVs
dCBpbmplY3Rpb24gc3VwcG9ydCBmb3IgbWV0YWRhdGEgY2FjaGUgYWxsb2NhdGlvbnMKPiB0byBp
bXByb3ZlIGVycm9yLXBhdGggdGVzdCBjb3ZlcmFnZS4KPiAtIGl0IGludGVncmF0ZXMgZW50cnkg
YWxsb2NhdGlvbnMgd2l0aCBGQVVMVF9LQUxMT0MKRkFVTFRfS0FMTE9DIC0+ICBGQVVMVF9LTUFM
TE9DPwo+Cj4gU2lnbmVkLW9mZi1ieTogQ2hhbyBZdSA8Y2hhb0BrZXJuZWwub3JnPgo+IC0tLQo+
ICBmcy9mMmZzL2NhY2hlLmMgfCAyNCArKysrKysrKysrKysrKy0tLS0tLS0tLS0KPiAgMSBmaWxl
IGNoYW5nZWQsIDE0IGluc2VydGlvbnMoKyksIDEwIGRlbGV0aW9ucygtKQo+Cj4gZGlmZiAtLWdp
dCBhL2ZzL2YyZnMvY2FjaGUuYyBiL2ZzL2YyZnMvY2FjaGUuYwo+IGluZGV4IDcyNjBjMTU3NjU0
Yi4uZGNhYjBmMzIxNzMwIDEwMDY0NAo+IC0tLSBhL2ZzL2YyZnMvY2FjaGUuYwo+ICsrKyBiL2Zz
L2YyZnMvY2FjaGUuYwo+IEBAIC0xNTQsMjMgKzE1NCwyNyBAQCBzdGF0aWMgc3RydWN0IGYyZnNf
Y2FjaGVkX2Jsb2NrICpmMmZzX2NyZWF0ZV9jYWNoZSgKPiAgICAgICAgICAgICAgICAgc3RydWN0
IGYyZnNfY2FjaGVkX2Jsb2NrX2xpc3QgKmNhY2hlLAo+ICAgICAgICAgICAgICAgICB1bnNpZ25l
ZCBsb25nIGluZGV4LCBib29sIG5vZmFpbCkKPiAgewo+ICsgICAgICAgc3RydWN0IGYyZnNfc2Jf
aW5mbyAqc2JpID0gY2FjaGUtPnNiaTsKPiAgICAgICAgIHN0cnVjdCBmMmZzX2NhY2hlZF9ibG9j
ayAqZW50cnk7Cj4gICAgICAgICB1bnNpZ25lZCBpbnQgZmxhZ3MgPSBHRlBfTk9GUzsKPgo+ICAg
ICAgICAgaWYgKGluZGV4ID09IFVMT05HX01BWCkKPiAgICAgICAgICAgICAgICAgcmV0dXJuIEVS
Ul9QVFIoLUVSQU5HRSk7Cj4KPiAtICAgICAgIGlmIChub2ZhaWwpCj4gKyAgICAgICBpZiAobm9m
YWlsKSB7Cj4gICAgICAgICAgICAgICAgIGZsYWdzIHw9IF9fR0ZQX05PRkFJTDsKPiAtCj4gLSAg
ICAgICBlbnRyeSA9IGt6YWxsb2Nfb2JqKCplbnRyeSwgZmxhZ3MpOwo+IC0gICAgICAgaWYgKCFl
bnRyeSkKPiAtICAgICAgICAgICAgICAgcmV0dXJuIEVSUl9QVFIoLUVOT01FTSk7Cj4gLQo+IC0g
ICAgICAgZW50cnktPmRhdGEgPSBrbWFsbG9jKGNhY2hlLT5zYmktPmJsb2Nrc2l6ZSwgZmxhZ3Mp
Owo+IC0gICAgICAgaWYgKCFlbnRyeS0+ZGF0YSkgewo+IC0gICAgICAgICAgICAgICBrZnJlZShl
bnRyeSk7Cj4gLSAgICAgICAgICAgICAgIHJldHVybiBFUlJfUFRSKC1FTk9NRU0pOwo+ICsgICAg
ICAgICAgICAgICBlbnRyeSA9IGt6YWxsb2Nfb2JqKCplbnRyeSwgZmxhZ3MpOwo+ICsgICAgICAg
ICAgICAgICBlbnRyeS0+ZGF0YSA9IGttYWxsb2Moc2JpLT5ibG9ja3NpemUsIGZsYWdzKTsKPiAr
ICAgICAgIH0gZWxzZSB7Cj4gKyAgICAgICAgICAgICAgIGVudHJ5ID0gZjJmc19remFsbG9jKHNi
aSwgc2l6ZW9mKCplbnRyeSksIGZsYWdzKTsKPiArICAgICAgICAgICAgICAgaWYgKCFlbnRyeSkK
PiArICAgICAgICAgICAgICAgICAgICAgICByZXR1cm4gRVJSX1BUUigtRU5PTUVNKTsKPiArCj4g
KyAgICAgICAgICAgICAgIGVudHJ5LT5kYXRhID0gZjJmc19rbWFsbG9jKHNiaSwgc2JpLT5ibG9j
a3NpemUsIGZsYWdzKTsKPiArICAgICAgICAgICAgICAgaWYgKCFlbnRyeS0+ZGF0YSkgewo+ICsg
ICAgICAgICAgICAgICAgICAgICAgIGtmcmVlKGVudHJ5KTsKPiArICAgICAgICAgICAgICAgICAg
ICAgICByZXR1cm4gRVJSX1BUUigtRU5PTUVNKTsKPiArICAgICAgICAgICAgICAgfQo+ICAgICAg
ICAgfQo+Cj4gICAgICAgICBlbnRyeS0+aW5kZXggPSBpbmRleDsKPiAtLQo+IDIuNDkuMAo+Cj4K
Pgo+IF9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCj4gTGlu
dXgtZjJmcy1kZXZlbCBtYWlsaW5nIGxpc3QKPiBMaW51eC1mMmZzLWRldmVsQGxpc3RzLnNvdXJj
ZWZvcmdlLm5ldAo+IGh0dHBzOi8vbGlzdHMuc291cmNlZm9yZ2UubmV0L2xpc3RzL2xpc3RpbmZv
L2xpbnV4LWYyZnMtZGV2ZWwKCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwpMaW51eC1mMmZzLWRldmVsIG1haWxpbmcgbGlzdApMaW51eC1mMmZzLWRldmVs
QGxpc3RzLnNvdXJjZWZvcmdlLm5ldApodHRwczovL2xpc3RzLnNvdXJjZWZvcmdlLm5ldC9saXN0
cy9saXN0aW5mby9saW51eC1mMmZzLWRldmVsCg==
