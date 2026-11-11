Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6FAF606A31C
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 11 Nov 2026 21:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=jzq38pvz;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=RlZ+yzxG;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=QNl5wncL;
	dkim=neutral header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UqbCpL5y
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:To:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:List-Owner;
	bh=hGQta0tWXwUd34ZXwl3PhlJt6TBCgw61YBFidN+Mf9A=; b=jzq38pvzKWM/kIr3N0ju3ABAbG
	+TiabO4f+ysraYjrlC6GWubt8hgT68mIafY75sMU94R7JDTVHvDFI5JKBZq6HoojOOmb87TUFPgoz
	WW3EAhX5QXHZi4gJZHobsYkqIlnC4nxvPS/P2YIWsRL+1Z0+6upUOz0uho+Q2Vsnhs9E=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xRFrj-000000007NC-2pub;
	Wed, 11 Nov 2026 21:28:23 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <daeho43@gmail.com>) id 1xRFrJ-000000007LD-371A
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 11 Nov 2026 21:27:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:Cc:To:
 Subject:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=aLuN5oKQufqiM+Zk/c+lXYNiAxXZh/RaJZ1xmrkPNfY=; b=RlZ+yzxGX17rCK64HNgZ0kCJfP
 d9Dq/Z+/fFKwIPQ0AQ6RjzdkJrCwHmADhHAavn3LniFyRTBrYKzjZTNBEfa2KOgY5NfmPQ+ERmlz5
 oxP/43v4vWrFNst+7rvFS52mvl+O6ZVB6zA9vrEEX+8NO1gFrhNwxWvGgXTDNPUXii+k=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:Cc:To:Subject:Message-ID:Date:From
 :In-Reply-To:References:MIME-Version:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=aLuN5oKQufqiM+Zk/c+lXYNiAxXZh/RaJZ1xmrkPNfY=; b=QNl5wncLLZADlQEh+hPjSgf4Wd
 qcfZQnVe8Njhd8esqckJ8QNxFLNmGJKN1Y2e2lJ+KXd38C8/c03dQqXdVJw5ACJCRshRBsighjgP8
 hY5Srsfd/eGzVa6a7YY8Vpx19xXCTMvs4m9ZVg6bMZNwPsKRDBSSCzxHqUtfJqqHGWeQ=;
Received: from mail-lj1-f178.google.com ([209.85.208.178])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xRFrG-000000003or-4AQQ
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 11 Nov 2026 21:27:57 +0000
Received: by mail-lj1-f178.google.com with SMTP id
 38308e7fff4ca-3ae0d0b9db2so18532091fa.1
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed, 11 Nov 2026 13:27:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794432468; cv=none;
 d=google.com; s=arc-20260327;
 b=flfGt8TvLJbEEnUtCHUjOiK9GL5bDh45ff7g8Uk55rTghiZC5fRQ66HNf8aELwx2eo
 1OjBuROny4f1vl2f4aqrDstVUDBlQ2aaG2t1a8PbZSIHMCifZSCz9vVDa9Pr1cGqlhAi
 J/VLaIi7HAeA34hidy0HhQ87mQlGCvnh4WqwGvmnI5VRKJh2E4cLkZxy9ep67IgXDNFD
 xzABMMPKK1RiI/2iINoAMUH5R816xY5Viq68zC8WgCf3XAOi+j1OtGNHI0RjcBkaRW5i
 l6qNrQLpyQK0zJ7kVVJoyrzojVI1GvRCdht//Iv8KjgTrU35ZW3h8CfDHYCJQPmY3t7t
 kB5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=aLuN5oKQufqiM+Zk/c+lXYNiAxXZh/RaJZ1xmrkPNfY=;
 fh=OD5N7akkPuaxZcvKYBto8fHjq6zFIws1eSsuzapkPUo=;
 b=TJAy26ffn6Uy20Qcg+6+7NmQQ2ThQb1eY0c617UmleHAsnJV5Ty234Y9IJp/xBZ2Bs
 tIaKE29vF4dH6AgE0ODXaFPKrMEPEZl9DXY2LStND+yjOcdlRWnZv+Yc3dA0eCCKq9kR
 vifB5nouOSI8q/cQ8mk79EsJIZA/a8aKPfywBZ8sgksvhc20hM0MeCmRp9bM6el1fKCu
 YppAJReIvcG66psKfxOOn6Gd9KRWepCoCdGfL3TL/2/ayBTjTNs1NQGQ8ePlfXKsrpVp
 dYPT1uCEjnHJi4SN80z5q5aCSFdmF5bqdvjCNKeMU79xAaNu63Ir0HUqJvoG2oCpBLCL
 S80A==; darn=lists.sourceforge.net
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794432468; x=1795037268; darn=lists.sourceforge.net;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=aLuN5oKQufqiM+Zk/c+lXYNiAxXZh/RaJZ1xmrkPNfY=;
 b=UqbCpL5yTpKdhtnxWIcuo+J8faYsa83CsOVSVnkP2tETjPiN4Xp8Pu0o2JrU2Eanju
 5vr28CDqe/8PHLykpXiO6kgD75WijeGYLqFN8Pa+ABfWZ/xzbrrecXhQCNIermUjug0S
 pndZGilXQ0lzox9QcztNSht5ycJIirMb7vtyHQHPLyCqfVK5toGM9fP1ryNPk2ku3GuJ
 /Yfc+OwcRE0kKf2XQj5ccfDfQFUfvAgF9eRSYWedOvJRpq0RK0H7ECpnUfbHlTLTzngG
 5W4crmlT5aH9VTWCphm1gNecjYPaaON53YLUskBAGbqmEGK4nZs0qb/sDwUAXJUI4DOx
 Mubg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794432468; x=1795037268;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=aLuN5oKQufqiM+Zk/c+lXYNiAxXZh/RaJZ1xmrkPNfY=;
 b=BkDz8UIb5kwfcWm6HvQQRqu+5eAPkL2LjB0NTlFbUXX/tNf4OCE+ebpaYPP2xxvS6w
 rhMeHqbT5Pt+6TB1hMe/po74QMGOnap0QIdE24Ec++F1T5AFgUIzQeCF4MrLglmLZw1J
 Y/QQ4gvYebIfs1iNBWObXn4VuDP+eZf7xLpX2RAJB10StBy30FrgyJN8xjqAIPHv5T0U
 HjiygdOXaI0wknkLfc0YcnujbPjhBlgsQcndDvwJTPA8/VpACAFjH2lNNmQQD5Uq2Wlp
 eJ13yMFBRjN1yXKkc2GfZ5MHWyjx2OPh9N2u+wzGBWtVSkWgRyCbQn6uUP4jdUByLi+z
 42Ug==
X-Forwarded-Encrypted: i=1;
 AL+hErHnc0Gm/BU9GTGLRj9UKmjiWdSee4QbgepU+AacpoGmCu3VWrzGrYj0EpxgYgiusM3/O4JBr6bhfE9UCeEzw5mY@lists.sourceforge.net
X-Gm-Message-State: APuU4Z/jZA/0dXE3Q9fkvFuiKAoIoh5otUt9CJJ6Q/8C2YDwQf8FhKfW
 DT1VpZFI/gPFaaKY1OeQcIvreIDHQoSCMyfjhB+ceyTOKaFNk2Rc/KmV8FaQ8i59NMmvUqoQtW0
 0iLD3nnzlUgKm9MOojwOITTRrAmfAQKg=
X-Gm-Gg: AYBFou334uoEYwz2bkocjF61XkUSV/YQurRAPLSYVAClrCGuHMaJlyhrA1fHTlP7XUA
 +lZDDtUWqGRHccg2pA35E4uWuqdGQXUm/QpB+DyGqecPQ2lC6LR0DoEey+OWwZ3BMriWnaePVpF
 CVO/8Nqgr5X1bDQqfU5d8QX0SvKJgPAb8UDofI1sF+VsMMbdif5Zkne4OdUo3FiMY9rnKPKsV2i
 yo8GbhxCtWR0FocZPBCN/tS2aUOmgAdOA6RRa1z38XYg00XhD8N1GdvqY+v0CMw2z6bzaiLvvnh
 8GNbxbbJFefeupZsOSrkeXbZ3h55zP/OAhonRkZVN+XJLKsyF5BurwDnIItV+JU6d5wggesB+i+
 WQtxkQa+1nTfWwQ2D0SuY00GXIwqLyIjd560jQJntNTaBiyrDd6ZCdZabcLHjnhzlfmcke6tm7e
 nXOgXw4XM+HCP2vdq+U3WY3REA
X-Received: by 2002:a2e:a803:0:b0:3a5:dfd3:41b9 with SMTP id
 38308e7fff4ca-3ae12681cfbmr7144081fa.14.1794432467929; Wed, 11 Nov 2026
 13:27:47 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261102193952.3002018-1-daeho43@gmail.com>
 <20261102193952.3002018-4-daeho43@gmail.com>
 <b3c98bba-69c8-4350-a9eb-0942be336f93@kernel.org>
 <CACOAw_ypOkWNWW8=8fn8gmnWnwrFDENYCHT-mXKjSEOL-UCYZg@mail.gmail.com>
 <20261111103947.3560570-1-nzzhao.sigma@gmail.com>
In-Reply-To: <20261111103947.3560570-1-nzzhao.sigma@gmail.com>
From: Daeho Jeong <daeho43@gmail.com>
Date: Wed, 11 Nov 2026 13:27:36 -0800
X-Gm-Features: AclHuK9auUWdrRWyc3gN9W3oAcV_VqBMD80KYSptwGEjRvbc9Rgeyxrbf4ewLT4
Message-ID: <CACOAw_yoyOFN0qJpSGLSesKpoJHqY3XnszVsQcSj48LamBP1zQ@mail.gmail.com>
To: Nanzhe Zhao <nzzhao.sigma@gmail.com>
X-Spam-Score: 1.1 (+)
X-Headers-End: 1xRFrG-000000003or-4AQQ
Subject: Re: [f2fs-dev] [PATCH 03/20] f2fs: extend f2fs_folio_state for
 subpage blocks
X-BeenThere: linux-f2fs-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: kernel-team@android.com, Daeho Jeong <daehojeong@google.com>,
 linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=0.1 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,FORGED_GMAIL_RCVD,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

T24gV2VkLCBOb3YgMTEsIDIwMjYgYXQgMjo0MOKAr0FNIE5hbnpoZSBaaGFvIDxuenpoYW8uc2ln
bWFAZ21haWwuY29tPiB3cm90ZToKPgo+IEhpIERhZWhvLAo+Cj4gPiAtIE1ha2UgdGhlIHVwdG9k
YXRlIGFuZCBkaXJ0eSBoZWxwZXJzIHRha2UgYmxvY2sgaW5kaWNlcy4gQWxsb2NhdGUgdGhlCj4g
PiAgIHN0YXRlIG9uIGRlbWFuZCB3aXRoIF9fR0ZQX05PRkFJTCwgc28gY2FsbGVycyBubyBsb25n
ZXIgaGFuZGxlIGFuCj4gPiAgIGFsbG9jYXRpb24gZmFpbHVyZS4KPgo+IEkgcmVtZW1iZXIgeW91
IHJhaXNlZCB0aGlzIGNvbmNlcm4gd2hlbiByZXZpZXdpbmcgdGhlIGxhcmdlLWZvbGlvIHNlcmll
cyBbMV06Cj4KPiA+IEkgdW5kZXJzdGFuZCBpdCBpcyB1c2VkIHRvIGF2b2lkIGZhaWxpbmcgaW4t
ZmxpZ2h0IEkvTyBvciB3cml0ZWJhY2sKPiA+IHdoZW4gYWxsb2NhdGluZyB0aGUgc3VicGFnZSBz
dGF0ZS4gSG93ZXZlciwgaW52b2tpbmcgX19HRlBfTk9GQUlMIGluCj4gPiBtZW1vcnkgcmVjbGFp
bS93cml0ZWJhY2sgcGF0aHMgcmlza3MgT09NIGxpdmVsb2NrcyB1bmRlciBleHRyZW1lCj4gPiBt
ZW1vcnkgcHJlc3N1cmUuCj4gPgo+ID4gSWRlYWxseSwgd2Ugc2hvdWxkIGVuc3VyZSBmZnMgaXMg
YWx3YXlzIHByZS1hbGxvY2F0ZWQgZHVyaW5nCj4gPiB3cml0ZV9iZWdpbigpIGFuZCBwYWdlX21r
d3JpdGUoKSAod2hlcmUgcmV0dXJuaW5nIC1FTk9NRU0gdG8gdXNlcnNwYWNlCj4gPiBpcyBzYWZl
KSwgc28gdGhhdCB0aGUgd3JpdGViYWNrIHBhdGggbmV2ZXIgaGFzIHRvIGFsbG9jYXRlIGZmcyBv
biB0aGUKPiA+IGZseSB3aXRoIF9fR0ZQX05PRkFJTC4KPgo+IFsxXSBodHRwczovL2xvcmUua2Vy
bmVsLm9yZy9saW51eC1mMmZzLWRldmVsL0NBQ09Bd196RF9hMzJVQ0paK0Y3ekQ2MW8wSzhRQWg3
UUtKVnVhZzRmbTk4cVd5N1NSUUBtYWlsLmdtYWlsLmNvbS8KPgo+IE5vdyB0aGlzIHBhdGNoIHVz
ZXMgR0ZQX05PSU8gfCBfX0dGUF9OT0ZBSUwgYWdhaW4uIE1heSBJIGFzayB3aHkgd2UgY2hhbmdl
ZAo+IGJhY2s/IElzIHRoZSBsaXZlbG9jayBjb25jZXJuIG5vIGxvbmdlciBhcHBsaWNhYmxlIHdp
dGggdGhlCj4gc3VicGFnZS1ibG9jayBkZXNpZ24/CgpIaSBOYW56aGUsCgpZb3UncmUgcmlnaHQs
IEkgY2hhbmdlZCBpdCBhbmQgc2hvdWxkIGhhdmUgZXhwbGFpbmVkIHdoeS4KCk15IGVhcmxpZXIg
Y29uY2VybiB3YXMgYWJvdXQgYWxsb2NhdGluZyB0aGUgc3RhdGUgaW4gd3JpdGViYWNrLiBUaGF0
IGlzCnN0aWxsIGF2b2lkZWQ6IHdyaXRlX2JlZ2luKCksIHBhZ2VfbWt3cml0ZSgpIGFuZCBHQyBh
dHRhY2ggdGhlIHN0YXRlCmJlZm9yZSBhIGZvbGlvIGlzIGRpcnRpZWQsIHNvIHdyaXRlYmFjayBm
aW5kcyBpdCBhbHJlYWR5IHRoZXJlLiAodjEKbWlzc2VkIG9uZSBjb21wcmVzc2VkIGNhc2UuIEl0
IGlzIGZpeGVkIGluIHYyLikKClRoZSByZWFzb24gZm9yIF9fR0ZQX05PRkFJTCBpcyBkaWZmZXJl
bnQuIFdpdGggc3VicGFnZSBibG9ja3MsIGV2ZXJ5CmZvbGlvIHdpdGggbW9yZSB0aGFuIG9uZSBi
bG9jayBuZWVkcyB0aGUgc3RhdGUsIGluY2x1ZGluZyBkaXJlY3RvcnkKZm9saW9zLiBUaGUgaGVs
cGVycyB0aGF0IG1hcmsgYmxvY2tzIGRpcnR5IG9yIHVwdG9kYXRlIGF0dGFjaCBpdCB3aGVuIGl0
CmlzIG1pc3NpbmcsIGFuZCBzb21lIG9mIHRoZWlyIGNhbGxlcnMgY2Fubm90IHJldHVybiBhbiBl
cnJvciwgZS5nLgpmMmZzX3NldF9saW5rKCkgYW5kIGYyZnNfZGVsZXRlX2VudHJ5KCkgYXJlIHZv
aWQuIFNvIHRoZSBhbGxvY2F0aW9uIGRvZXMKbm90IGZhaWwsIGxpa2UgaWZzX2FsbG9jKCkgaW4g
aW9tYXAuCgpJIHdpbGwgYWRkIHRoaXMgdG8gdGhlIGNvbW1pdCBtZXNzYWdlIGluIHYyLgoKPgo+
IEFsc28sIHBsZWFzZSBub3RlIHRoZSB3YXJuaW5nIHJlcG9ydGVkIGJ5IHRoZSBrZXJuZWwgdGVz
dCByb2JvdAo+IChsa3BAaW50ZWwuY29tKToKPgo+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xp
bnV4LWYyZnMtZGV2ZWwvMjAyNjExMDUwMTQ0LjQ3Qk9WYWs1LWxrcEBpbnRlbC5jb20vCj4KPiBJ
dCByZXBvcnRzOgo+Cj4gICBmcy9mMmZzL2RhdGEuYzo1MTk2OjM0OiB3YXJuaW5nOiB2YXJpYWJs
ZSAnZmZzJyBzZXQgYnV0IG5vdCB1c2VkCgpUaGFua3MsIEkgd2lsbCBmaXggaXQgaW4gdjIuCgo+
Cj4gaW4gcHJlcGFyZV9sYXJnZV9mb2xpb193cml0ZV9iZWdpbigpLiBUaGlzIGFwcGVhcmVkIGFm
dGVyIHRoZQo+IGBpZiAoIWZmcykgcmV0dXJuIC1FTk9NRU07YCBjaGVjayB3YXMgcmVtb3ZlZCBp
biB0aGlzIHBhdGNoLiBDb3VsZCB5b3UKPiBwbGVhc2UgdGFrZSBhIGxvb2sgYW5kIGxldCBtZSBr
bm93IGlmIHlvdSBuZWVkIG1lIHRvIHNlbmQgYSBmaXggcGF0Y2g/Cj4KPiBUaGFua3MsCj4gTmFu
emhlCgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTGlu
dXgtZjJmcy1kZXZlbCBtYWlsaW5nIGxpc3QKTGludXgtZjJmcy1kZXZlbEBsaXN0cy5zb3VyY2Vm
b3JnZS5uZXQKaHR0cHM6Ly9saXN0cy5zb3VyY2Vmb3JnZS5uZXQvbGlzdHMvbGlzdGluZm8vbGlu
dXgtZjJmcy1kZXZlbAo=
