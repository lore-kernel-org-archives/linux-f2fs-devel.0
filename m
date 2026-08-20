Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18226C5DF87
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 20 Aug 2026 12:19:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:To:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pOlxIrO2ozTNIAsR/vl6fKQtDjn47wOUNQimmwvNoy8=; b=bcpmtFtS/SCv9Yx7x2TIupGZSD
	nGY9cabzpksDPr2idJZBqf1cf/jm457RSBaP3xdEKqtk4PE3jf9QwhlQwP7HKA8LhzmpG0pyYNCsC
	pHa1a5HBRiw4E/IDjyk9otA6g3U6EfHAgo38WCMQc43C0oY1+sCjIBGhTbty485n36u0=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wx1jf-00038j-40;
	Thu, 20 Aug 2026 12:19:07 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <qwjhust@gmail.com>) id 1wx1je-00038d-68
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 20 Aug 2026 12:19:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:Cc:To:
 Subject:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=BTK4lhWPo27COqi0EqImtblLyxZMR832mEXXg7NbytI=; b=d9TIimpbWQKDsJQNmq0m/wCq3C
 3/SLo3x27+3Vl9yGph5ewoRBeOFVeRXjsjI08VJ04mniyQFnEDxzkU0cG1u9xfTdVSbXmghJHj/vd
 fPMDTY/svNKSGwdkq0mtBY7636eJqQeHj7xKu+e8RlL5gWSjR4G+JDntFyDWlMQIPvZE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:Cc:To:Subject:Message-ID:Date:From
 :In-Reply-To:References:MIME-Version:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=BTK4lhWPo27COqi0EqImtblLyxZMR832mEXXg7NbytI=; b=bmoQJIDIZeMjh93+a48Vd005td
 fM/MF5Ffwf7ZGyIijj+tfqy5wnAA577fMFb7W8qGTxG0DjtDZLUajusJ43TKE2g2FCsTRHHKa8hj2
 jhhibSHOerPt1Ftq3ifvTm1QJpLoUlseDMNRIVPMg65ZsHpHhWS46zkZeNRzfi04erNs=;
Received: from mail-lj1-f171.google.com ([209.85.208.171])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wx1jd-0007jJ-Jm for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 20 Aug 2026 12:19:06 +0000
Received: by mail-lj1-f171.google.com with SMTP id
 38308e7fff4ca-39da69c5ba3so21965691fa.1
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu, 20 Aug 2026 05:19:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787228339; cv=none;
 d=google.com; s=arc-20260327;
 b=jcKh5WAf5RnV5sxzAKWoW9Cca5MiCm1cxUazg9Sx+FIN2yUAyxsCCyTv+Tg6eDpgCc
 U/7su1kaCH0qA3f6qwyVVlwsqM24cVbmO2WvdiEuRqp64pKc4yWnJFLJX2uIuR9mNtZS
 DjIkQPGQwXKSshNegRMGuBFvBCIfBet54LqBi1jAzoVjIfL5BCldY8DAtWqGouSAspZy
 fC+fnpEe51lgZTOdhc7bXxAJ9rPGMQAyz8nk1DTppLhiIE4N5wP7fOQScjLihUAFFpPh
 sJShBa5vmZoGYGv32nrwP8/1r1FjpuJN5SFs8ZWfCsosSkzGK2rxruFR6oe6tkbDAUeU
 SkYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=BTK4lhWPo27COqi0EqImtblLyxZMR832mEXXg7NbytI=;
 fh=mBMPrVxB31jtKX6bnAldL29rTVV78/OVj9SYM1AqyVM=;
 b=CdemtZQMIRSq9sIlvg9PRvzx6iXmaIh+NOCC+Y1mVj0ozoSX+nxiCS1Kx3GKXo2pPi
 TfOcqL7OG/W+LsC38GF6cdjiHCQ/MHPvILDOdWWpnSuFln0HQv30snviuzEy4AWatGq8
 RABxEfgJseMPrgYr7KNJtKZJH82hl4gLGqcrH/tp82rLWvz9BzNBgTtIIPdcB8LwPkut
 S5F7dVxAgOSTK9LkxIyiwXw91bZBDBnL/3EmsoO/JR2azvGkXQPi4+StPLjvXzCgqw3l
 WuOISw42r76RyEqaMVmuz6cEQ0Ah+uJoXht2r8fLPiqh+q0VZJ4nkFBVZPAll4CXooKK
 7qNw==; darn=lists.sourceforge.net
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787228339; x=1787833139; darn=lists.sourceforge.net;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=BTK4lhWPo27COqi0EqImtblLyxZMR832mEXXg7NbytI=;
 b=JVMlGOqXX+jo5j6fY+QaVD4o89DP537nqI4ggwzoZEelwpNFz1N8EtGf8ce9rS+JFo
 7qKy5l5GccpCTHm+TxPQVJsxenUfyh6sZ49IyDJhXHWj2NfmVVjImU50zKH0+MI7hjhs
 sU+130HkFiiK9LCuhjtMP+Sv0rfta/VLlfpDjFrjOdtiNl0KjlxnIUjDCwk0oSrQ168V
 ZbuJhikWt9ct0qV3oMi4+YEKtnVLMZTUGGWIbja9TUCezAYYWGIhbIcgRN4+cDN1lgrc
 G8rx3sBqQseBogpYdfoitPPH7I7ZtHkk957ZowZVmskC4/o6DzAtzgloHujJ/RfO2ZXj
 sSNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787228339; x=1787833139;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=BTK4lhWPo27COqi0EqImtblLyxZMR832mEXXg7NbytI=;
 b=RJKamUDGSxU6N1g3yPX4YRBHdFJFNbYj+nEjsb/fhXluk/HWnbUvLbNO3+gB5bnagk
 DYSqlIMuYgsVo4f5wABxTEdeDH2jaPDpp5IbzmLNtAOGq9xvzsdRU5iQPNNZnRL2ox6Z
 JeJeDQql1KSf9XuUM5fsSmShY/x6oOcDv3Vje3NrIGfYgYNvLQVov9wGnDZkYYPgni7x
 2GBfLeeBJmKAf/TZx0GQg6DlxgcFElbY8MxeNxZ+emBwroo8tr0T3r3iNReV8DOZV31E
 ncRS7d1qCJbT3JNJUuFRkKCSxUJDQGLkIRsDthsnTB3HaAJXm+EXBH5uILRidHgxnbmg
 LpXA==
X-Forwarded-Encrypted: i=1;
 AHgh+RrjVA24ij9Jhu07re4U92VNxMZmL0fP1+guKN1LSOv8w9sp+RqD6CbqqDXeIqmpjC9JP6zfE7dig6OsBcCCoFd+@lists.sourceforge.net
X-Gm-Message-State: AOJu0Ywxbg7rpp0Up5WGZ1Q4wMe+iTgBf+hFRgwk1OgrUn3xne51TPDQ
 +AWx1ZBhtpChJGokwqcWirBOb2MJC0/iozutkcFfQqyXRh5Z7mX/aum/ZFp36XLkdcQMxhEsUkT
 tys6D4Ce1bfDl7eNGvYIY8iNG9Nt4Z9E=
X-Gm-Gg: AR+sD10q1/HrGAim6sIrLpg8pcYDeJW8+quiddzz2pBUPxOsg7vQfH652aoIZK8Ft2A
 TcK85LvvRmqZQNziQFEnjneVlHb94t74uaZm+RMvuNRmSy0RtpvOUsr7U7968Lg+CREdRvAstgn
 YVD3cwxn2PLOBbRpAg9qbL8NrgvjWzgJXX0asQd9c5gnEi8N+9PEc52bSjjREKL0tBEGCS+XKLo
 AkB8s+aRNOgIVDOxGiXywVIA9RYTvaWfyLBnxsvVAXfloQwFeNRozOUpP1Y27qchfYQ7jWC586r
 H0bxYeyvUuUCmdf9Tlp5GS9ZsoBi0+PwC9GN8yVDPrD1BQ==
X-Received: by 2002:a05:651c:a110:20b0:39c:93ff:3672 with SMTP id
 38308e7fff4ca-3a1899d693amr20872001fa.9.1787228338519; Thu, 20 Aug 2026
 05:18:58 -0700 (PDT)
MIME-Version: 1.0
References: <20260820071438.695893-1-qiwenjie@xiaomi.com>
 <20260820071438.695893-2-qiwenjie@xiaomi.com>
 <CAGsJ_4wQZUZLBxOaRt-ax4QBRaa5PNf+xpJrT_b=rZzyhDGLkA@mail.gmail.com>
In-Reply-To: <CAGsJ_4wQZUZLBxOaRt-ax4QBRaa5PNf+xpJrT_b=rZzyhDGLkA@mail.gmail.com>
From: Wenjie Qi <qwjhust@gmail.com>
Date: Thu, 20 Aug 2026 20:18:46 +0800
X-Gm-Features: AcwNN1ULSxRkWeC8FhT91Vq7CGve_jm1Daqi6hul-ZQEXQIxerwbGXj-QUfD9LU
Message-ID: <CAGFpFsRXX33j9uxpoVpS9CWQkPh=ijrDSBh=qCxFS1RABG8xDg@mail.gmail.com>
To: Barry Song <baohua@kernel.org>
X-Headers-End: 1wx1jd-0007jJ-Jm
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
Cc: jaegeuk@kernel.org, qiwenjie@xiaomi.com, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

ICBIaSBCYXJyeSwKCiAgYmlvX2luX2F0b21pYygpIGlzIG5vdCBpbiB0aGUgY3VycmVudCBmMmZz
IGRldi10ZXN0IGJhc2UgeWV0LCBzbyB2MgogIGNhcnJpZXMgdGhlIHNhbWUgcHJlZGljYXRlIGxv
Y2FsbHkuIEkgd2lsbCByZXBsYWNlIGl0IHdpdGgKICBiaW9faW5fYXRvbWljKCkgb25jZSB0aGUg
YmxvY2sgcHVsbCBpcyBtZXJnZWQgaW50byB0aGUgYmFzZS4KCiAgSSBhbHNvIGNoZWNrZWQgQWxl
eGFuZHJlJ3MgdjMgc2VyaWVzLiBJdHMgZGVmZXJyZWQgcGF0aCBpcyBjdXJyZW50bHkKICBzcGVj
aWZpYyB0byBzd2FwLWNhY2hlIGZvbGlvcy4gZm9saW9fZW5kX3dyaXRlYmFjaygpIGRldGVjdHMg
YQogIGRyb3BiZWhpbmQgc3dhcC1jYWNoZSBmb2xpbyBhbmQgY2FsbHMgc3dhcF93cml0ZWJhY2tf
ZHJvcGJlaGluZF9mb2xpbygpLAogIHdoaWxlIHRoZSBwZXItQ1BVIGxpc3RzIGFuZCBzd2FwX2Ry
b3BiZWhpbmRfd3EgbGl2ZSBpbiBtbS9zd2FwX3N0YXRlLmMuCiAgVGhlIG5vbi1zd2FwIHBhdGgg
c3RpbGwgY2FsbHMgZm9saW9fZW5kX2Ryb3BiZWhpbmQoKSBkaXJlY3RseSwgc28gdGhlCiAgc2Vy
aWVzIGRvZXMgbm90IHlldCBwcm92aWRlIGEgY29tbW9uIGRlZmVycmVkIHBhdGggZm9yIGZpbGUt
YmFja2VkCiAgZm9saW9zLgoKICBUaGlzIEYyRlMgcGF0Y2ggcmV1c2VzIHRoZSBleGlzdGluZyBz
YmktPndxIHJhdGhlciB0aGFuIGFsbG9jYXRpbmcgYSBuZXcKICB3b3JrcXVldWUsIGFsdGhvdWdo
IHRoZSBjb21wbGV0aW9uIGRlZmVycmFsIHJlbWFpbnMgRjJGUy1zcGVjaWZpYy4KCiAgUmVnYXJk
cywKICBXZW5qaWUKCk9uIFRodSwgQXVnIDIwLCAyMDI2IGF0IDc6NDXigK9QTSBCYXJyeSBTb25n
IDxiYW9odWFAa2VybmVsLm9yZz4gd3JvdGU6Cj4KPiBPbiBUaHUsIEF1ZyAyMCwgMjAyNiBhdCAz
OjIx4oCvUE0gV2VuamllIFFpIDxxd2podXN0QGdtYWlsLmNvbT4gd3JvdGU6Cj4gPgo+ID4gQnVm
ZmVyZWQgUldGX0RPTlRDQUNIRSB3cml0ZXMgaW52YWxpZGF0ZSBkcm9wYmVoaW5kIGZvbGlvcyBm
cm9tIHdyaXRlYmFjawo+ID4gY29tcGxldGlvbi4gS2VlcCBub3JtYWwgYW5kIGRyb3BiZWhpbmQg
Zm9saW9zIGluIHNlcGFyYXRlIHdyaXRlIGJpb3MsIGFuZAo+ID4gZGVmZXIgYSBkcm9wYmVoaW5k
IGJpbyB0byBzYmktPndxIHVubGVzcyBjb21wbGV0aW9uIHJ1bnMgaW4KPiA+IHByZWVtcHRpYmxl
IHRhc2sgY29udGV4dC4KPiA+Cj4gPiBVc2UgdGhlIHNhbWUgZWxpZ2liaWxpdHkgY29uZGl0aW9u
cyBhcyB0aGUgcHJvcG9zZWQgYmlvX2luX2F0b21pYygpIGhlbHBlci4KPiA+IFVubGlrZSAhaW5f
dGFzaygpLCB0aGlzIGFsc28gY292ZXJzIGRpc2FibGVkIHByZWVtcHRpb24gYW5kIHByZWVtcHRp
YmxlIFJDVQo+ID4gcmVhZC1zaWRlIGNyaXRpY2FsIHNlY3Rpb25zLgo+ID4KPiA+IEtlZXAgdGhl
IGV4aXN0aW5nIGxhcmdlLUFUQyBkZWZlcnJhbCB1bmNoYW5nZWQuCj4gPgo+ID4gTGluazogaHR0
cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGludXgtbW0vMjAyNjA3MzAtYmxrLWRvbnRjYWNoZS12Ny0w
LTNlOGU2ODUwMDY4ZEBjb2x1bWJpYS5lZHUvCj4gPiBTaWduZWQtb2ZmLWJ5OiBXZW5qaWUgUWkg
PHFpd2VuamllQHhpYW9taS5jb20+Cj4gPiAtLS0KPiA+ICBmcy9mMmZzL2RhdGEuYyB8IDUwICsr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKy0tLS0tLS0tCj4gPiAgMSBm
aWxlIGNoYW5nZWQsIDQyIGluc2VydGlvbnMoKyksIDggZGVsZXRpb25zKC0pCj4gPgo+ID4gZGlm
ZiAtLWdpdCBhL2ZzL2YyZnMvZGF0YS5jIGIvZnMvZjJmcy9kYXRhLmMKPiA+IGluZGV4IDZhZTBl
YjM3ZDIwLi43NzRhM2UyZDhlMyAxMDA2NDQKPiA+IC0tLSBhL2ZzL2YyZnMvZGF0YS5jCj4gPiAr
KysgYi9mcy9mMmZzL2RhdGEuYwo+ID4gQEAgLTIxLDYgKzIxLDcgQEAKPiA+ICAjaW5jbHVkZSA8
bGludXgvZmllbWFwLmg+Cj4gPiAgI2luY2x1ZGUgPGxpbnV4L2lvbWFwLmg+Cj4gPiAgI2luY2x1
ZGUgPGxpbnV4L2ZzZXJyb3IuaD4KPiA+ICsjaW5jbHVkZSA8bGludXgvcmN1cGRhdGUuaD4KPiA+
Cj4gPiAgI2luY2x1ZGUgImYyZnMuaCIKPiA+ICAjaW5jbHVkZSAibm9kZS5oIgo+ID4gQEAgLTQz
LDkgKzQ0LDI5IEBAIHN0cnVjdCBmMmZzX2ZvbGlvX3N0YXRlIHsKPiA+Cj4gPiAgc3RydWN0IGYy
ZnNfYmlvIHsKPiA+ICAgICAgICAgc3RydWN0IHdvcmtfc3RydWN0IHdvcms7Cj4gPiArICAgICAg
IGJvb2wgZHJvcGJlaGluZDsKPiA+ICAgICAgICAgc3RydWN0IGJpbyBiaW87Cj4gPiAgfTsKPiA+
Cj4gPiArc3RhdGljIHN0cnVjdCBmMmZzX2JpbyAqdG9fZjJmc19iaW8oc3RydWN0IGJpbyAqYmlv
KQo+ID4gK3sKPiA+ICsgICAgICAgcmV0dXJuIGNvbnRhaW5lcl9vZihiaW8sIHN0cnVjdCBmMmZz
X2JpbywgYmlvKTsKPiA+ICt9Cj4gPiArCj4gPiArLyogS2VlcCBpbiBzeW5jIHdpdGggdGhlIHBy
b3Bvc2VkIGJsb2NrLWxheWVyIGJpb19pbl9hdG9taWMoKS4gKi8KPiA+ICtzdGF0aWMgYm9vbCBm
MmZzX2Jpb19pbl9hdG9taWModm9pZCkKPiA+ICt7Cj4gPiArI2lmZGVmIENPTkZJR19QUkVFTVBU
SU9OCj4gPiArICAgICAgIGlmIChyY3VfcHJlZW1wdF9kZXB0aCgpKQo+ID4gKyAgICAgICAgICAg
ICAgIHJldHVybiB0cnVlOwo+ID4gKyNlbmRpZgo+ID4gKyNpZm5kZWYgQ09ORklHX1BSRUVNUFRf
Q09VTlQKPiA+ICsgICAgICAgcmV0dXJuIHRydWU7Cj4gPiArI2Vsc2UKPiA+ICsgICAgICAgcmV0
dXJuICFwcmVlbXB0aWJsZSgpOwo+ID4gKyNlbmRpZgo+ID4gK30KPiA+ICsKPgo+IEhpIFdlbmpp
ZSwKPgo+IEkgc2VlIHRoYXQgdGhpcyBbMV0gaGFzIGFscmVhZHkgYmVlbiBpbmNsdWRlZCBpbiB0
aGUgcHVsbCByZXF1ZXN0IFsyXSwKPiBzbyBwZXJoYXBzIHlvdSBjYW4gdXNlIGJpb19pbl9hdG9t
aWMoKSBkaXJlY3RseSBvbmNlIGl0IGxhbmRzLgo+Cj4gQWxzbywgSSBmZWVsIHRoYXQgc29tZXRo
aW5nIGlzIHF1aXRlIG9kZCB3aXRoIG1tL2ZpbGVtYXAuYy4KPiBJdCBzaG91bGRuJ3QgcmVxdWly
ZSBldmVyeW9uZSB0byByZWludmVudCB0aGVpciBvd24gd29ya3F1ZXVlcywgYXMgSQo+IG1lbnRp
b25lZCBoZXJlIFszXS4gSSBhbHNvIG5vdGljZWQgdGhhdCBBbGV4YW5kcmUgaXMgYWRkaW5nIGEg
d29ya3F1ZXVlCj4gaW4gZmlsZW1hcC5jWzRdLCB3aGljaCBtaWdodCBiZSBleHRlbmRlZCB0byBm
aWxlIHBhZ2UgY2FjaGUgaGFuZGxpbmcgYXMKPiB3ZWxsIGluIHRoZSBmdXR1cmUuCj4KPiBbMV0g
aHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxsLzIwMjYwNzMwLWJsay1kb250Y2FjaGUtdjctMS0z
ZThlNjg1MDA2OGRAY29sdW1iaWEuZWR1Lwo+IFsyXSBodHRwczovL2xvcmUua2VybmVsLm9yZy9h
bGwvODc4N2ExNzYtNmY0Yi00N2ZjLWEzMDktODY3YWNmOWZiZGZmQGtlcm5lbC5kay8KPiBbM10g
aHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxsL0NBR3NKXzR3VXZMb0tHYWZSM1Utamkxa1VVYXo2
S19RZE42UXhNVC1hcFNhTzV0WHAwQUBtYWlsLmdtYWlsLmNvbS8KPiBbNF0gaHR0cHM6Ly9sb3Jl
Lmtlcm5lbC5vcmcvYWxsLzIwMjYwODE4MTYzMjIxLjU4OTM1Mi0zLWFsZXhAZ2hpdGkuZnIvCj4K
PiBUaGFua3MKPiBCYXJyeQoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fCkxpbnV4LWYyZnMtZGV2ZWwgbWFpbGluZyBsaXN0CkxpbnV4LWYyZnMtZGV2ZWxA
bGlzdHMuc291cmNlZm9yZ2UubmV0Cmh0dHBzOi8vbGlzdHMuc291cmNlZm9yZ2UubmV0L2xpc3Rz
L2xpc3RpbmZvL2xpbnV4LWYyZnMtZGV2ZWwK
