Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DDA0C44536
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 21 Jan 2026 19:00:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:To:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Ggbm8v0B/XNGwmu+8eMg3by08Ivn749J/sVLs4NpxB8=; b=QNVnUYYNwIm1UAW/eSo18N63tE
	ri9pdLZkWT/9MuoRGGOyEK6s4TBmIdMgno2UgVDZbHjHsWWZI8BM71SJiwB10zwKZxPrGMBTjsDCA
	CxgPUvjcan6pniBH3Rga1m6cksSIl0b5sDDkN67Zwig8DTeY70sP3WHf+0QU9p2bw0v4=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1vidRF-0008MT-4K;
	Wed, 21 Jan 2026 19:00:21 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <amir73il@gmail.com>) id 1vidRE-0008MM-0f
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 21 Jan 2026 19:00:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:Cc:To:
 Subject:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=P50vKKEGRcti/ilk0zXXEyTeAkMnj2pLP0nOzx4jcho=; b=VtFo4baG5eHVunHiPZ4VoJOIok
 IWufSSsd/h/JYpKpOY/lykCflidjKrWaXrz44VnqGqzCVdyXA2bxMDxMdQE/T2TpXMnsNWILbycgj
 C4wGY6BPJKNhAUGRYe9u/fevES132ATGD5sMKHBlTyOnNfAtJRClCwXS81EwQhh1CM3g=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:Cc:To:Subject:Message-ID:Date:From
 :In-Reply-To:References:MIME-Version:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=P50vKKEGRcti/ilk0zXXEyTeAkMnj2pLP0nOzx4jcho=; b=e61KA+laBkAylmaiEdGDYKtqkv
 VXe5TPbYp2l1RnJ4QOe2aY7tcG3iHj/miNV8opsKDV65gG58Cl97hSFSATNek20gVg5yfXBGnz82Z
 dh6eJnE3RN6joRmCsvcWo9VoCMrDqQHce5ndXClWBKIzhrrT/DDClW4yZtPVgwm0njHY=;
Received: from mail-ej1-f53.google.com ([209.85.218.53])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1vidRD-00006Y-MQ for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 21 Jan 2026 19:00:19 +0000
Received: by mail-ej1-f53.google.com with SMTP id
 a640c23a62f3a-b8719aeebc8so16386766b.3
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed, 21 Jan 2026 11:00:19 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769022008; cv=none;
 d=google.com; s=arc-20240605;
 b=SF9NN4VrmDjGFGJpwgecnup8mKssyqVsu+WyNmwmCb1THmI/8jTwKUMQiEN0D2zdes
 wt60EhOUm9GuNIt6nepoHNG49+H1VHvPZ/J1N/+gciA5u98820ZzkZaJJb92tnXak4Vk
 vfEMtoJcl783f9UOs2MjvkRzRmhbb98zy5X+/3nQ/Tv62u6IyX3tAnFWDpPBjyPjut1f
 Z/VbNRj074Opn1waNrAmfnbdIf+oQE48XDW1+xkGcZxrbxzc8Dhkas7loBfpv8b6vncL
 nFmVBVP9uBWy875q75kVj5Pimfw1iS/gamNdpVK3jTnXZi3MwcaK9IkNtsyifNZNDrcw
 C2Zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=P50vKKEGRcti/ilk0zXXEyTeAkMnj2pLP0nOzx4jcho=;
 fh=2EGFhUcKbCHlR7d8/icnqM8KugSBbMN+h4x3XcmQ8TI=;
 b=HT53jaTZHriDxwf5IwDmWnWL19rzHYZyf4H4EWs6lTfMbx7fuXVw9aGyinw7gB2zz5
 JTFnNx9PLo6m9EQyI6xhMRVquuwF/5OiV16+uriiZvXWvS3j593pnW/Ddz8ZWZ50skYH
 H/cuBXul2MtfiOjJEBxPpEzXl3ai0+XPP2eFpn2DoKR0fSdFZt5Gt8vPWg10Z0E3ew4M
 OYn0cT6cZ3uQg7zo/B/6EqqkSPFRUX5cjf/QZbR+KfjueFqMt9lA1KpaFhoCnKScWa9m
 Si6ZLlplFygihFMxAJfqCuuiE668sW8zIqLtkGTO2UNiTMImBNfFTg3vjtIOW8dLFAqD
 ZwNQ==; darn=lists.sourceforge.net
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1769022008; x=1769626808; darn=lists.sourceforge.net;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=P50vKKEGRcti/ilk0zXXEyTeAkMnj2pLP0nOzx4jcho=;
 b=mOzULpvN+6377kOx9Kk4mD88IkoXVPA6cJkhUf+WuAd1DMmC9ONMiUAwbY8yx6ZuHz
 WSwHszdZsV11NAMtathI6xaLDbcyMxHP+KTKVFDWWOTbYVbDrR2dh7SjqbMJkMvRBAwr
 Ql8PHxcN81LY5MgIfdHPLr6Vrcr0w0Aw1JR7Fk17dcg3SdCnThVTwUb//G7+ZCHfsbvw
 kEviWz1O0Q6igaWIpFnkIlwg3yuFao6FDT2opXwnMKr8dDKOvj75aQo6OrQn4e2u9qYr
 DlGF6c7bm7wDqtyT3Ay/BTBLAqO01Suz7RYHRrZYTHhhID+Epd0uPh7cLfMWSQ6AaIU+
 ojCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769022008; x=1769626808;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=P50vKKEGRcti/ilk0zXXEyTeAkMnj2pLP0nOzx4jcho=;
 b=lE3VNI6X4LTiGcqQgKsCWxJncEeIr/QXEFpPaj4Z68lFZ3TW8+NAOSryOHgPBcDjSd
 fOP09TTC2+OybLaQQ9BIoNtHHWs5BbwvZDEqYo/HcW+6MQN7urczC9DgsvDNJfbbUF0D
 b+cnHobkS+R8fuITDSliOLoHf5uJ2lKmqvmMdCb22KVnKTYOTedgOBHDDKfqSivlBT89
 7I2PiGlI8c8jvQF+nq5e9FE8+4CprdrDSOn5TNS5INnX7EJ7Aq/c+YbJqlVSGMB/bclQ
 DXymVfv3Yvm7BbsHaTrXwtqDOoPqVwP5wsSGMZhmeR7eXi7O0y78rmoOSJdYfn3ITia5
 hFig==
X-Forwarded-Encrypted: i=1;
 AJvYcCVWhitaaqcHH1QkWAF0Q+5lHVFiUyq/jFyl9pCpkohaY+LPFegYRKbAgIqeQkDjzD50hrJJmseKpSIbfC+tKW3r@lists.sourceforge.net
X-Gm-Message-State: AOJu0Yz7ime5I2+KQvCf5O9lE1A5AxTwTqCPxIVmj3naMKhMsfOBhbgU
 7xOjfSE4QV+r8lDLHf17hsoTFZoq0bjd+C36sfBCekiuzti69ZHeIuLSarYBlHMyQ13+ghQddZ0
 /TByWoRJJFWCBACZjZpb456YqvwAxiq0=
X-Gm-Gg: AZuq6aJRgJlRypFVFqvImHFRJFjXJvnmk+jGHF1k9q4dxU1Vq7pyZwi44cPXnce/lE2
 An7JC0ZXrSwpecSSvfMoh02SHORwpaTsfouyKU9Nh/3k+6NNw7fsrbRothHupmYPa1b4i//2+Aw
 G10sA9Cg/Calcf4lhrmiHBth+bG6NApshL5HvoVzSTixk1PJTqJIf4Xh2NBJ/wFMguW5JwtaJDj
 kfxqfCCtonXNmyxYWjBsTV1TtFpAB5y3YAdyAwXAbpvr5XRoMt7Dez1GvgywWNJBWBkfzorn3g+
 rNt9n5hN3atCjVJc0/bORuNnqWo=
X-Received: by 2002:a17:906:6a13:b0:b87:206a:a23b with SMTP id
 a640c23a62f3a-b8792f79852mr1477117366b.34.1769022007470; Wed, 21 Jan 2026
 11:00:07 -0800 (PST)
MIME-Version: 1.0
References: <20260115-exportfs-nfsd-v1-0-8e80160e3c0c@kernel.org>
 <CAOQ4uxjOJMwv_hRVTn3tJHDLMQHbeaCGsdLupiZYcwm7M2rm3g@mail.gmail.com>
 <9c99197dde2eafa55a1b55dce2f0d4d02c77340a.camel@kernel.org>
 <176877859306.16766.15009835437490907207@noble.neil.brown.name>
 <aW3SAKIr_QsnEE5Q@infradead.org>
 <176880736225.16766.4203157325432990313@noble.neil.brown.name>
 <20260119-kanufahren-meerjungfrau-775048806544@brauner>
 <176885553525.16766.291581709413217562@noble.neil.brown.name>
 <20260120-entmilitarisieren-wanken-afd04b910897@brauner>
 <176890211061.16766.16354247063052030403@noble.neil.brown.name>
 <20260120-hacken-revision-88209121ac2c@brauner>
 <a35ac736d9ebc6c92a6e7d61aeb5198234102442.camel@kernel.org>
 <176896790525.16766.11792073987699294594@noble.neil.brown.name>
 <ccb32c576cc4ebf943d5ec35e3d7ba4ae8892acd.camel@kernel.org>
In-Reply-To: <ccb32c576cc4ebf943d5ec35e3d7ba4ae8892acd.camel@kernel.org>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 21 Jan 2026 19:59:56 +0100
X-Gm-Features: AZwV_Qh050IhjThhArfxNo-53HjJR0uLCcITEQOtntS-75Lw875opD6ONQssxps
Message-ID: <CAOQ4uxg+dC1o+6V7Nvxf8UW3H=0OvsGjEe76LNY6q8ZcpGDDJw@mail.gmail.com>
To: Jeff Layton <jlayton@kernel.org>
X-Headers-End: 1vidRD-00006Y-MQ
Subject: Re: [f2fs-dev] [PATCH 00/29] fs: require filesystems to explicitly
 opt-in to nfsd export support
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
Cc: Martin Brandenburg <martin@omnibond.com>,
 jfs-discussion@lists.sourceforge.net, Jan Kara <jack@suse.cz>,
 Paulo Alcantara <pc@manguebit.org>, Alex Markuze <amarkuze@redhat.com>,
 Sandeep Dhavale <dhavale@google.com>, linux-btrfs@vger.kernel.org,
 Carlos Maiolino <cem@kernel.org>, linux-unionfs@vger.kernel.org,
 Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
 Chris Mason <clm@fb.com>, Andreas Dilger <adilger.kernel@dilger.ca>,
 Chunhai Guo <guochunhai@vivo.com>, Ronnie Sahlberg <ronniesahlberg@gmail.com>,
 linux-mtd@lists.infradead.org, Mike Marshall <hubcap@omnibond.com>,
 linux-xfs@vger.kernel.org, linux-nilfs@vger.kernel.org,
 Yue Hu <zbestahu@gmail.com>, Miklos Szeredi <miklos@szeredi.hu>,
 Richard Weinberger <richard@nod.at>, Mark Fasheh <mark@fasheh.com>,
 Hugh Dickins <hughd@google.com>, Dai Ngo <Dai.Ngo@oracle.com>,
 Ryusuke Konishi <konishi.ryusuke@gmail.com>,
 Christoph Hellwig <hch@infradead.org>, Viacheslav Dubeyko <slava@dubeyko.com>,
 NeilBrown <neil@brown.name>, Gao Xiang <xiang@kernel.org>,
 linux-ext4@vger.kernel.org, Salah Triki <salah.triki@gmail.com>,
 linux-mm@kvack.org, devel@lists.orangefs.org,
 Shyam Prasad N <sprasad@microsoft.com>,
 Olga Kornievskaia <okorniev@redhat.com>, linux-cifs@vger.kernel.org,
 Dave Kleikamp <shaggy@kernel.org>, linux-nfs@vger.kernel.org,
 Tom Talpey <tom@talpey.com>, ocfs2-devel@lists.linux.dev,
 Bharath SM <bharathsm@microsoft.com>, David Sterba <dsterba@suse.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 Jeffle Xu <jefflexu@linux.alibaba.com>, Jaegeuk Kim <jaegeuk@kernel.org>,
 ceph-devel@vger.kernel.org, Ilya Dryomov <idryomov@gmail.com>,
 OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
 Andreas Gruenbacher <agruenba@redhat.com>, gfs2@lists.linux.dev,
 Christian Brauner <brauner@kernel.org>, Theodore Ts'o <tytso@mit.edu>,
 Luis de Bethencourt <luisbg@kernel.org>,
 Joseph Qi <joseph.qi@linux.alibaba.com>, linux-erofs@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 Steve French <sfrench@samba.org>, Chuck Lever <chuck.lever@oracle.com>,
 Hongbo Li <lihongbo22@huawei.com>, Anna Schumaker <anna@kernel.org>,
 Jan Kara <jack@suse.com>, linux-fsdevel@vger.kernel.org,
 Phillip Lougher <phillip@squashfs.org.uk>,
 Andrew Morton <akpm@linux-foundation.org>, ntfs3@lists.linux.dev,
 David Woodhouse <dwmw2@infradead.org>, Trond Myklebust <trondmy@kernel.org>,
 Joel Becker <jlbec@evilplan.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

T24gV2VkLCBKYW4gMjEsIDIwMjYgYXQgMTI6NTbigK9QTSBKZWZmIExheXRvbiA8amxheXRvbkBr
ZXJuZWwub3JnPiB3cm90ZToKPgouLi4KPiA+IEJ1dCBpZiB5b3UgcmVhbGx5IHJlYWxseSB3YW50
IHRvIHNldCB0aGlzIG5ldyBmbGFnIG9uIGFsbW9zdCBldmVyeQo+ID4gZXhwb3J0X29wZXJhdGlv
bnMsIGNhbiBJIGFzayB0aGF0IHlvdSBwbGVhc2Ugc2V0IGl0IG9uIEVWRVJZIGV4cG9ydAo+ID4g
b3BlcmF0aW9ucywgdGhlbiBhbGxvdyBtYWludGFpbmVycyB0byByZW1vdmUgaXQgYXMgdGhleSBz
ZWUgZml0Lgo+ID4gSSB0aGluayB0aGF0IGFwcHJvYWNoIHdvdWxkIGJlIG11Y2ggZWFzaWVyIHRv
IHJldmlldy4KPiA+Cj4KPiBXZSBjb3VsZCBwcm9iYWJseSBkbyB0aGF0LCBidXQgSSB0aGluayB0
aGUgbWFpbiBvbmVzIHRoYXQgZXhjbHVkZXMgaXQKPiBhcmUga2VybmZzLCBwaWRmcyBhbmQgbnNm
cy4gb3ZsIGFuZCBmdXNlIGFsc28gaGF2ZSBleHBvcnQgb3BzIGluCj4gY2VydGFpbiBtb2RlcyB0
aGF0IGV4Y2x1ZGUgTkZTIGFjY2Vzcywgc28gdGhlIGZsYWcgd2FzIGxlZnQgb2ZmIG9mCj4gdGhv
c2UgYXMgd2VsbC4KPgoKRm9yIHRoZSByZWNvcmQsIG15IGNvbW1lbnRzIHJlZ2FyZGluZyBmdXNl
X2V4cG9ydF9maWRfb3BlcmF0aW9ucwphbmQgb3ZsX2V4cG9ydF9maWRfb3BlcmF0aW9ucyB2YXJp
YW50cyB3ZXJlIHB1cmVseSBzZW1hbnRpYyAtCml0IGRpZCBub3QgbWFrZSBzZW5zZSB0byBtYXJr
IHRoZW0gYXMgX1NUQUJMRV9IQU5ETEUsIGJ1dAppdCBkb2VzIG5vdCBtYXR0ZXIgaWYgeW91IHNl
dCBhIGZsYWcgb24gdGhvc2Ugb3BzLCBiZWNhdXNlIHRoZXkgZG8Kbm90IGltcGxlbWVudCAtPmZo
X3RvX2RlbnRyeSgpLCBvbiBwdXJwb3NlLCB0aGV5IGFyZSBub3QKZXhwb3J0ZnNfY2FuX2RlY29k
ZV9maCgpIGJ5IGRlc2lnbi4KClRoYW5rcywKQW1pci4KCgpfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwpMaW51eC1mMmZzLWRldmVsIG1haWxpbmcgbGlzdApM
aW51eC1mMmZzLWRldmVsQGxpc3RzLnNvdXJjZWZvcmdlLm5ldApodHRwczovL2xpc3RzLnNvdXJj
ZWZvcmdlLm5ldC9saXN0cy9saXN0aW5mby9saW51eC1mMmZzLWRldmVsCg==
