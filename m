Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0598BC0015E
	for <linux-f2fs-devel@archiver.kernel.org>; Wed,  9 Aug 2023 19:42:04 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1qTp4E-0004Fg-9P;
	Wed, 09 Aug 2023 19:42:02 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <hubcap@omnibond.com>) id 1qTp46-0004FG-NH
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 09 Aug 2023 19:41:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:Cc:To:
 Subject:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=9EcmI8Rpl1R+tuyjPLJAOGmabIt197aKHT+nbD52Q1I=; b=erLewfC6tLyPRe52+06ybmZoNc
 SEiztqgUnEfmvFIFf28p/rBHpmtTXHK8Tfmy4CIEuOO2R6B/xZ3VuwereucNvQUR/cbVALVraV+Lt
 WAGcOlkebCeJVnIMrAPQHLHL4Ys+8Z2O+fOjh8Ppb5SUhXcuZpbNihOusB/8vZ4nNknA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:Cc:To:Subject:Message-ID:Date:From
 :In-Reply-To:References:MIME-Version:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=9EcmI8Rpl1R+tuyjPLJAOGmabIt197aKHT+nbD52Q1I=; b=DR8SPDphneLDMqLF1v6yDH42Jp
 9HfkAxwauF8NikrUnDqJbk33NDNIiCLW85lD7xc8ofhINSZ7i7wV+Oxh/fo5YNIE2F/R1Cb+00+39
 HnZa+9tqYqBZlLmRwZqvHnb+N4IBEncc4Dui2bzcpUxxjbqaO6+zVkKmRCjKJsBw8OCw=;
Received: from mail-ot1-f50.google.com ([209.85.210.50])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1qTp40-000m5m-LH for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 09 Aug 2023 19:41:54 +0000
Received: by mail-ot1-f50.google.com with SMTP id
 46e09a7af769-6b9c9944da8so148547a34.3
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed, 09 Aug 2023 12:41:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=omnibond-com.20221208.gappssmtp.com; s=20221208; t=1691610102; x=1692214902; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9EcmI8Rpl1R+tuyjPLJAOGmabIt197aKHT+nbD52Q1I=;
 b=3uiujuiLPOeGZCYhQKJTdZnZ1jyrGXsRq2KUZh9hqtIpBS7QMlHnZUjiLJ+zva/4NK
 15aq16JBk2ub7q3Gj+1jnoajumUSn03WKK0yH8GQX/3ix0JmAF2DMgR133zNrRxtv1kA
 ceJU0SN6wmDxUh1VmEunTCtqwZD6cbRRAjeePanhO+imQY+B9+5OKCKP12JKAxBVCghq
 WJaci5bE5WQWzDeJUXd8j3adIRaaKEGs6xAvslkLzQ75CCixPk2AWmcDIs0vfJfYbmqO
 3NTtckqVvEQ4Ad6C3cgUaJTeHqg/wy6gVHzRltcltLhvzbMYj9//C//yIkTK3sPGBk5N
 2VDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691610102; x=1692214902;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9EcmI8Rpl1R+tuyjPLJAOGmabIt197aKHT+nbD52Q1I=;
 b=dki1GDCtzpR/G9Ib5kabQla7X5f4KDLxz29kB8A5adN1/0L43WMOQjC9lMwX5tmw41
 sJeyTnyyfOYNo2RMkWivwr2Riaw/kvucLICZYKH/IaaMe7dD3P+7cf4s08y62Q4RbF09
 RrKnlGb6M+AgYkhm3MRn89igL9g9SV/IhdGoA/CA1Cg2V9FY39P6dxl0B0JvDhPpb+t4
 GczmvejqTnIvuwzpIorJVG8QGP/d2+SmWdMa4G9g2WRsypVVhlIRjWupmUQiX3Jqggx7
 WIXY2M/PXjqvlSTqPMYRpPMgRbbDUQY5FgrkWfQD7/o5+vn3aXdUS7ySgFntSBjR2M5S
 GrOw==
X-Gm-Message-State: AOJu0Yzl+k6WSW/9oX+aLa4UtNSAYgMZwm1z9+zP6TdD85sXippcDYKb
 NcXZPZ5EDlW7USriMmblPqIE42YOmb5MgBLLYEhoaxUCj/UprCW9x08=
X-Google-Smtp-Source: AGHT+IH2sTR1ARtIFCpkS6vqthNwZFelmGu0RmLRp1wcx6mBBfZ3SQAFevZE8DnhGTo57OILWEQYl9skWtT3uKB51ZE=
X-Received: by 2002:ac8:4e47:0:b0:3f9:c207:3123 with SMTP id
 e7-20020ac84e47000000b003f9c2073123mr166690qtw.45.1691606297822; Wed, 09 Aug
 2023 11:38:17 -0700 (PDT)
MIME-Version: 1.0
References: <20230807-mgctime-v7-0-d1dec143a704@kernel.org>
 <20230807-mgctime-v7-8-d1dec143a704@kernel.org>
 <20230809-segeln-pflaumen-460b81bd2d3a@brauner>
In-Reply-To: <20230809-segeln-pflaumen-460b81bd2d3a@brauner>
From: Mike Marshall <hubcap@omnibond.com>
Date: Wed, 9 Aug 2023 14:38:07 -0400
Message-ID: <CAOg9mST=WFAjEwS9eNi_huoUpBvPy3R3fbFVTLUeFZAv6BJEEQ@mail.gmail.com>
To: Christian Brauner <brauner@kernel.org>
X-Headers-End: 1qTp40-000m5m-LH
Subject: Re: [f2fs-dev] [PATCH v7 08/13] fs: drop the timespec64 argument
 from update_time
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
Cc: Latchesar Ionkov <lucho@ionkov.net>,
 Martin Brandenburg <martin@omnibond.com>,
 Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
 linux-xfs@vger.kernel.org, "Darrick J. Wong" <djwong@kernel.org>,
 Dominique Martinet <asmadeus@codewreck.org>,
 Christian Schoenebeck <linux_oss@crudebyte.com>, ecryptfs@vger.kernel.org,
 linux-unionfs@vger.kernel.org, David Howells <dhowells@redhat.com>,
 Chris Mason <clm@fb.com>, Andreas Dilger <adilger.kernel@dilger.ca>,
 Hans de Goede <hdegoede@redhat.com>, Marc Dionne <marc.dionne@auristor.com>,
 samba-technical@lists.samba.org, codalist@coda.cs.cmu.edu,
 linux-afs@lists.infradead.org, linux-mtd@lists.infradead.org,
 Paulo Alcantara <pc@manguebit.com>, linux-cifs@vger.kernel.org,
 Eric Van Hensbergen <ericvh@kernel.org>,
 Andreas Gruenbacher <agruenba@redhat.com>, Miklos Szeredi <miklos@szeredi.hu>,
 Richard Weinberger <richard@nod.at>, Mark Fasheh <mark@fasheh.com>,
 Hugh Dickins <hughd@google.com>, Benjamin Coddington <bcodding@redhat.com>,
 Tyler Hicks <code@tyhicks.com>, cluster-devel@redhat.com, coda@cs.cmu.edu,
 linux-mm@kvack.org, Ilya Dryomov <idryomov@gmail.com>,
 Iurii Zaikin <yzaikin@google.com>, Namjae Jeon <linkinjeon@kernel.org>,
 Trond Myklebust <trond.myklebust@hammerspace.com>,
 Shyam Prasad N <sprasad@microsoft.com>, Amir Goldstein <amir73il@gmail.com>,
 Kees Cook <keescook@chromium.org>, ocfs2-devel@lists.linux.dev,
 Josef Bacik <josef@toxicpanda.com>, Tom Talpey <tom@talpey.com>,
 Tejun Heo <tj@kernel.org>, Yue Hu <huyue2@coolpad.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Ronnie Sahlberg <ronniesahlberg@gmail.com>, David Sterba <dsterba@suse.com>,
 Jaegeuk Kim <jaegeuk@kernel.org>, ceph-devel@vger.kernel.org,
 Xiubo Li <xiubli@redhat.com>, Gao Xiang <xiang@kernel.org>,
 OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>, Jan Harkes <jaharkes@cs.cmu.edu>,
 linux-nfs@vger.kernel.org, linux-ext4@vger.kernel.org,
 Theodore Ts'o <tytso@mit.edu>, Joseph Qi <joseph.qi@linux.alibaba.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, v9fs@lists.linux.dev,
 ntfs3@lists.linux.dev, Jeff Layton <jlayton@kernel.org>,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 Steve French <sfrench@samba.org>,
 Sergey Senozhatsky <senozhatsky@chromium.org>,
 Luis Chamberlain <mcgrof@kernel.org>, Jeffle Xu <jefflexu@linux.alibaba.com>,
 devel@lists.orangefs.org, Anna Schumaker <anna@kernel.org>,
 Jan Kara <jack@suse.com>, Bob Peterson <rpeterso@redhat.com>,
 linux-fsdevel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 Sungjong Seo <sj1557.seo@samsung.com>, linux-erofs@lists.ozlabs.org,
 linux-btrfs@vger.kernel.org, Joel Becker <jlbec@evilplan.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

SSd2ZSBiZWVuIGZvbGxvd2luZyB0aGlzIHBhdGNoIG9uIGZzZGV2ZWwuLi4gaXMgdGhlcmUgYQpy
ZW1vdGUgSSBjb3VsZCBmZXRjaCB3aXRoIGEgYnJhbmNoIHRoYXQgaGFzIHRoaXMgaW4gaXQ/Cgot
TWlrZQoKT24gV2VkLCBBdWcgOSwgMjAyMyBhdCA4OjMy4oCvQU0gQ2hyaXN0aWFuIEJyYXVuZXIg
PGJyYXVuZXJAa2VybmVsLm9yZz4gd3JvdGU6Cj4KPiBPbiBNb24sIEF1ZyAwNywgMjAyMyBhdCAw
MzozODozOVBNIC0wNDAwLCBKZWZmIExheXRvbiB3cm90ZToKPiA+IE5vdyB0aGF0IGFsbCBvZiB0
aGUgdXBkYXRlX3RpbWUgb3BlcmF0aW9ucyBhcmUgcHJlcGFyZWQgZm9yIGl0LCB3ZSBjYW4KPiA+
IGRyb3AgdGhlIHRpbWVzcGVjNjQgYXJndW1lbnQgZnJvbSB0aGUgdXBkYXRlX3RpbWUgb3BlcmF0
aW9uLiBEbyB0aGF0IGFuZAo+ID4gcmVtb3ZlIGl0IGZyb20gc29tZSBhc3NvY2lhdGVkIGZ1bmN0
aW9ucyBsaWtlIGlub2RlX3VwZGF0ZV90aW1lIGFuZAo+ID4gaW5vZGVfbmVlZHNfdXBkYXRlX3Rp
bWUuCj4gPgo+ID4gU2lnbmVkLW9mZi1ieTogSmVmZiBMYXl0b24gPGpsYXl0b25Aa2VybmVsLm9y
Zz4KPiA+IC0tLQo+ID4gIGZzL2JhZF9pbm9kZS5jICAgICAgICAgICB8ICAzICstLQo+ID4gIGZz
L2J0cmZzL2lub2RlLmMgICAgICAgICB8ICAzICstLQo+ID4gIGZzL2J0cmZzL3ZvbHVtZXMuYyAg
ICAgICB8ICA0ICstLS0KPiA+ICBmcy9mYXQvZmF0LmggICAgICAgICAgICAgfCAgMyArLS0KPiA+
ICBmcy9mYXQvbWlzYy5jICAgICAgICAgICAgfCAgMiArLQo+ID4gIGZzL2dmczIvaW5vZGUuYyAg
ICAgICAgICB8ICAzICstLQo+ID4gIGZzL2lub2RlLmMgICAgICAgICAgICAgICB8IDMwICsrKysr
KysrKysrKystLS0tLS0tLS0tLS0tLS0tLQo+ID4gIGZzL292ZXJsYXlmcy9pbm9kZS5jICAgICB8
ICAyICstCj4gPiAgZnMvb3ZlcmxheWZzL292ZXJsYXlmcy5oIHwgIDIgKy0KPiA+ICBmcy91Ymlm
cy9maWxlLmMgICAgICAgICAgfCAgMyArLS0KPiA+ICBmcy91Ymlmcy91Ymlmcy5oICAgICAgICAg
fCAgMiArLQo+ID4gIGZzL3hmcy94ZnNfaW9wcy5jICAgICAgICB8ICAxIC0KPiA+ICBpbmNsdWRl
L2xpbnV4L2ZzLmggICAgICAgfCAgNCArKy0tCj4KPiBUaGlzIHdhcyBtaXNzaW5nIHRoZSBjb252
ZXJzaW9uIG9mIGZzL29yYW5nZWZzIG9yYW5nZWZzX3VwZGF0ZV90aW1lKCkKPiBjYXVzaW5nIHRo
ZSBidWlsZCB0byBmYWlsLiBTbyBhdCBzb21lIHBvaW50IGtidWlsZCB3aWxsIHllbGwgaGVyZS4K
PiBGd2l3LCBJJ3ZlIGZpeGVkIHRoYXQgdXAgaW4tdHJlZS4KCgpfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwpMaW51eC1mMmZzLWRldmVsIG1haWxpbmcgbGlz
dApMaW51eC1mMmZzLWRldmVsQGxpc3RzLnNvdXJjZWZvcmdlLm5ldApodHRwczovL2xpc3RzLnNv
dXJjZWZvcmdlLm5ldC9saXN0cy9saXN0aW5mby9saW51eC1mMmZzLWRldmVsCg==
