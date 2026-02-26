Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71952FD9E0A
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 26 Feb 2026 21:34:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:To:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4Z4dH3U0+0VgE7Nk87AgIZ2XA3htaiqUh1v8Fj91Hqc=; b=hp/o7HOqhI0LZT60KdbiCmOch9
	tZhtT2Pr1ajXW5AcHaygZ085bY0TKSNidYShQtXsrKb+OUP7JczBvvXC/GkUc8V4l6ud7vNvcQmTm
	85Vl3pSdHNZloebb60ESnYsPB8HnPFJHgyoGWy3hyAZZj+VoaeZTgQZCQg0zm2YPTTso=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1vvj0N-0001m8-AS;
	Thu, 26 Feb 2026 21:34:43 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <paul@paul-moore.com>) id 1vvj0E-0001lu-5p
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 26 Feb 2026 21:34:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:Cc:To:
 Subject:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=zmNhsrxkJsNmzJoSll+GD0SvmHq0rQdZiw5NaBd3y6o=; b=PgWsQeILZjHmXVIcyIGa37cfPO
 ShoyS67dRjSwH4yor3k2i6NJdwWPm/MJ6r9f2S/TOh9pOFI0OHNKifKlzeZs6+2gz43TG2Zb3wg7I
 DGkZ5e+kiOevifh/fVmmdfENzCYnkTc+wicJapgsejjQz01cuBMaXF5l/nnyt62NlaEs=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:Cc:To:Subject:Message-ID:Date:From
 :In-Reply-To:References:MIME-Version:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=zmNhsrxkJsNmzJoSll+GD0SvmHq0rQdZiw5NaBd3y6o=; b=Syuu+fjr9Mf8E//jtkooXjBzce
 JbLsvqwLn+eRMMjomowTLPVJprPefqvR1myhfxiqwoT9EQ2FpXRj4vKPTyR66+QKNEAPqXV51jftf
 KyIzp2yQ7ph8F4FKxFEcotn1E1+kiTdFtB4NuSWWdqkqxmmaFCtTj6QO7BQinUTJsuUY=;
Received: from mail-qk1-f181.google.com ([209.85.222.181])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1vvj0D-0006R2-PE for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 26 Feb 2026 21:34:34 +0000
Received: by mail-qk1-f181.google.com with SMTP id
 af79cd13be357-8cb4136d865so160114485a.1
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu, 26 Feb 2026 13:34:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772141668; cv=none;
 d=google.com; s=arc-20240605;
 b=EEqAU/tXxgjszrC9vIX4qWl2JzCZC2OyDDeHFdV74/wrXfDavfTytAByz3eZ9Q5waL
 OeABaeKzXC8bcKI0u6I8G7N1UQdfLz3qouNMi0Y2O6Oj0HAiMfzYKqFC0i/IHznlzRS1
 7T0HQoimOhXDn2P46YJDOHlFzCTIg85v6fon0RYnbQR8GMB6CHkCyP8N87h6UknPNKPe
 3+s8LZ99OlylUP91Kqvnd3HsfHmAXcXPfwoxCeMJNxYpoNxLIbFWES+XOIHuPY7CTQuc
 XONbxIC7A+21N/aloOxBMKelh/zIZeA2W+pi/qVxl8Lm/gn9UrOkpzui67sfXjvAcqoq
 qZlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=zmNhsrxkJsNmzJoSll+GD0SvmHq0rQdZiw5NaBd3y6o=;
 fh=AQz7umQE4h09KfNWl0WmECbVjCbIcvZv2gTOtScJ6bE=;
 b=OMxm8eD74zxgx28HqOPmMmuDLOzNyMozf8KBjVPZDi+h14isBAXBXFdtDCizO5HwW6
 nXoX5c/JsXVatqD0CBPn0pb7r0FEVNtrbgZnhchtP/OUcvFP6eQ1WpfKbeDgPHQR9Dlr
 DkUC72APSd81MfC17RGP8q09zZdKsCbQJcUkOMvyYaOjnmUtWS/5AiJQXDQ/z2pkREX+
 eP6Qev0Z/MdKqhD80OExJkvizjov1G6dIM64VdqDEEV8lJ2uM6ZxpMvdnYdIc2WtCPRg
 20EjrKfa87GF2hsonsdf7UuhwwKJ4LA8oxogc9Nnw3IYO6QrPyV2nQjttAykgiUvIe3v
 WW8Q==; darn=lists.sourceforge.net
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=paul-moore.com; s=google; t=1772141668; x=1772746468;
 darn=lists.sourceforge.net; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zmNhsrxkJsNmzJoSll+GD0SvmHq0rQdZiw5NaBd3y6o=;
 b=DVmz8Zpww5JtIp3Fxt7yyGYGNDTXfEju0H8VXerRblxCsziBNWg1atZH4g/ApPCxkb
 y3D95gyJe+z0/MzzQRWUjZr/asTYUm8mbHS7Z7yiEPqFkh3gstpipz0thyV8A0lSTqqJ
 ckEqeBPWytSUGJh0+SI88366Y97/Tpy/XPxKnMvSUHBYQ9Klqgdo9XDEPvKQOw57cVWJ
 d1ClCz7I6vxV8R37D/8G4Quhi025sSh/kg8nv5Sf6UWXwGktMJw27mZzna8mW3BOUxw/
 zNgZhm/unc3XSZ2KnptJHJwF80lAW/XL68m5qx2T+UqbbHw0kzuR1dLyOtc56kbCAyjZ
 3sOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772141668; x=1772746468;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=zmNhsrxkJsNmzJoSll+GD0SvmHq0rQdZiw5NaBd3y6o=;
 b=peqGvTDJtQoGoSiIqLP7XxxRKDtTc9TXEskOq4dfYUgzJwONtaADDDKaFoNNk6C6/u
 uoudfHvfEIM6XVprpnRCJYHPu2cft2XgStcbmDtz+eZxm9/1a+Mz7gOy9RPMkQBKI8BE
 ZPkG3R559u9VGaisGjUIjIiDkhT0sXNLuvAzZY/AeSLlAisPOwMyVKfBVAaJURAF/I5J
 0E0hctq8nqewdIwlUJX+akwLcA6vGoMmrcxGZCkJ7YbFxDBak6A0sxC9bth6+wtIoj6m
 vjOpQe4gIxIZ7/WqhtMM1Y3kUz5PWqHxWSFU5aRjeM1yowlwwkbh5T0iGWxNvEarRJ1K
 +B3A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUOj60Qju0OAji/o8+SuSkRKD3vI9jqHEZBAmiyHRgpCfUT80xpO3+U9x0jWF3YIfc5eB9L3wwWRkwiMbE/EtDt@lists.sourceforge.net
X-Gm-Message-State: AOJu0YzuWPF/kbham2zFk7vAw1reruvryDJY4vhMea29CpdJOCgTwyvj
 0ldALIzcI4srWrX7QMmNrz2U7oUKJZMt2r7s0d8HSUELGgnztLiGAJ/761JAIFTvkkfnlMVM+wK
 4p0BdWBS5YFrJSCf1yUqbH5Gw+hFsnqF/LJDpUGotGLt+gSanVJ2OAQ==
X-Gm-Gg: ATEYQzwxK8jVJ4jV5xIQZyAnhclIie00FM8rfEt4K4LdCZ15EtT5xR0qcxjQ/7vV64j
 1KBIJAm860CDHnBG9gmbmlir49cG1b4xipCuMLWigsshh1pLjU9PD7yqfZCTLw/e5Aezynlr+g4
 oblv1JetswZHcXGoOgdheHReZshFjhO839AW5UzJECV2nNBmtx6GqKT/1FbScw5FtWM2ufAwCP6
 hEccFkbBphrFSWoO7c52xNKKdvIikj/xzwQCQRBmObVdM76/rNyOybFadTR0jaLEW/mWZcXSyKS
 KkwDde4=
X-Received: by 2002:a17:90b:574f:b0:359:877:370f with SMTP id
 98e67ed59e1d1-35965ccf029mr498632a91.17.1772140313953; Thu, 26 Feb 2026
 13:11:53 -0800 (PST)
MIME-Version: 1.0
References: <20260226-iino-u64-v1-0-ccceff366db9@kernel.org>
 <20260226-iino-u64-v1-51-ccceff366db9@kernel.org>
In-Reply-To: <20260226-iino-u64-v1-51-ccceff366db9@kernel.org>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 26 Feb 2026 16:11:41 -0500
X-Gm-Features: AaiRm51CHDvKlRV2Z04ZUK5c4lU9AiJhpRFTzD6a70HHA0FgEKDqsojtRqG1Wpw
Message-ID: <CAHC9VhTPutzjNfYoRJigC2AQS4wz1A3vTEYn2koeR0kKetYk0w@mail.gmail.com>
To: Jeff Layton <jlayton@kernel.org>
X-Headers-End: 1vvj0D-0006R2-PE
Subject: Re: [f2fs-dev] [PATCH 51/61] security: update audit format strings
 for u64 i_ino
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
Cc: Latchesar Ionkov <lucho@ionkov.net>, nvdimm@lists.linux.dev,
 Paulo Alcantara <pc@manguebit.org>, "Darrick J. Wong" <djwong@kernel.org>,
 Anders Larsen <al@alarsen.net>, dri-devel@lists.freedesktop.org,
 linux-hams@vger.kernel.org, Sumit Semwal <sumit.semwal@linaro.org>,
 Mike Marshall <hubcap@omnibond.com>, linux-xfs@vger.kernel.org,
 Fan Wu <wufan@kernel.org>, ceph-devel@vger.kernel.org,
 James Morris <jmorris@namei.org>, Tyler Hicks <code@tyhicks.com>,
 Christoph Hellwig <hch@infradead.org>, devel@lists.orangefs.org,
 Shyam Prasad N <sprasad@microsoft.com>, Martin Schiller <ms@dev.tdt.de>,
 Jan Harkes <jaharkes@cs.cmu.edu>, Willem de Bruijn <willemb@google.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>, linux-fscrypt@vger.kernel.org,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Ronnie Sahlberg <ronniesahlberg@gmail.com>,
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 David Hildenbrand <david@kernel.org>, Eric Van Hensbergen <ericvh@kernel.org>,
 Christian Brauner <brauner@kernel.org>,
 Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
 Stephen Smalley <stephen.smalley.work@gmail.com>, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>,
 Masami Hiramatsu <mhiramat@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
 Jan Kara <jack@suse.com>, Alex Deucher <alexander.deucher@amd.com>,
 linux-media@vger.kernel.org, Trond Myklebust <trondmy@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, Dave Kleikamp <shaggy@kernel.org>,
 Mimi Zohar <zohar@linux.ibm.com>, Oleg Nesterov <oleg@redhat.com>,
 Eric Dumazet <edumazet@google.com>, Simona Vetter <simona@ffwll.ch>,
 linux-cifs@vger.kernel.org, Kuniyuki Iwashima <kuniyu@google.com>,
 linux-nilfs@vger.kernel.org, codalist@coda.cs.cmu.edu,
 linux-trace-kernel@vger.kernel.org, Olga Kornievskaia <okorniev@redhat.com>,
 Yangtao Li <frank.li@vivo.com>, selinux@vger.kernel.org,
 linaro-mm-sig@lists.linaro.org, Casey Schaufler <casey@schaufler-ca.com>,
 netfs@lists.linux.dev, Jaegeuk Kim <jaegeuk@kernel.org>,
 fsverity@lists.linux.dev, "Theodore Y. Ts'o" <tytso@mit.edu>,
 Nicolas Pitre <nico@fluxnic.net>, Muchun Song <muchun.song@linux.dev>,
 Roberto Sassu <roberto.sassu@huawei.com>,
 "David S. Miller" <davem@davemloft.net>, Anna Schumaker <anna@kernel.org>,
 linux-integrity@vger.kernel.org, Alex Markuze <amarkuze@redhat.com>,
 Martin Brandenburg <martin@omnibond.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 ocfs2-devel@lists.linux.dev, jfs-discussion@lists.sourceforge.net,
 linux-mtd@lists.infradead.org, amd-gfx@lists.freedesktop.org,
 Marc Dionne <marc.dionne@auristor.com>, linux-afs@lists.infradead.org,
 Ian Kent <raven@themaw.net>, Naohiro Aota <naohiro.aota@wdc.com>,
 Eric Biggers <ebiggers@kernel.org>, Miklos Szeredi <miklos@szeredi.hu>,
 Matthew Wilcox <willy@infradead.org>, coda@cs.cmu.edu,
 Viacheslav Dubeyko <slava@dubeyko.com>, NeilBrown <neil@brown.name>,
 Ilya Dryomov <idryomov@gmail.com>, Paolo Abeni <pabeni@redhat.com>,
 "Serge E. Hallyn" <serge@hallyn.com>, Amir Goldstein <amir73il@gmail.com>,
 James Clark <james.clark@linaro.org>, autofs@vger.kernel.org,
 Steven Rostedt <rostedt@goodmis.org>, Damien Le Moal <dlemoal@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Dan Williams <dan.j.williams@intel.com>, Oscar Salvador <osalvador@suse.de>,
 Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
 linux-nfs@vger.kernel.org, linux-ext4@vger.kernel.org, linux-mm@kvack.org,
 samba-technical@lists.samba.org, Ondrej Mosnacek <omosnace@redhat.com>,
 Steve French <sfrench@samba.org>, linux-fsdevel@vger.kernel.org,
 ntfs3@lists.linux.dev,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Ian Rogers <irogers@google.com>, Alexander Aring <alex.aring@gmail.com>,
 Jan Kara <jack@suse.cz>, Peter Zijlstra <peterz@infradead.org>,
 Dominique Martinet <asmadeus@codewreck.org>,
 Christian Schoenebeck <linux_oss@crudebyte.com>, ecryptfs@vger.kernel.org,
 linux-unionfs@vger.kernel.org, David Howells <dhowells@redhat.com>,
 Joseph Qi <joseph.qi@linux.alibaba.com>,
 Andreas Dilger <adilger.kernel@dilger.ca>,
 Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>,
 linux-f2fs-devel@lists.sourceforge.net, David Airlie <airlied@gmail.com>,
 Eric Snowberg <eric.snowberg@oracle.com>, linux-x25@vger.kernel.org,
 Richard Weinberger <richard@nod.at>, Mark Fasheh <mark@fasheh.com>,
 Dai Ngo <Dai.Ngo@oracle.com>, Ingo Molnar <mingo@redhat.com>,
 Jakub Kicinski <kuba@kernel.org>, Salah Triki <salah.triki@gmail.com>,
 Simon Horman <horms@kernel.org>, apparmor@lists.ubuntu.com,
 Tom Talpey <tom@talpey.com>, Bharath SM <bharathsm@microsoft.com>,
 "Tigran A. Aivazian" <aivazian.tigran@gmail.com>,
 David Sterba <dsterba@suse.com>, Namhyung Kim <namhyung@kernel.org>,
 Ryusuke Konishi <konishi.ryusuke@gmail.com>,
 John Johansen <john.johansen@canonical.com>,
 Luis de Bethencourt <luisbg@kernel.org>, netdev@vger.kernel.org,
 v9fs@lists.linux.dev, Adrian Hunter <adrian.hunter@intel.com>,
 linux-security-module@vger.kernel.org, Johannes Thumshirn <jth@kernel.org>,
 David Woodhouse <dwmw2@infradead.org>, Joel Becker <jlbec@evilplan.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

T24gVGh1LCBGZWIgMjYsIDIwMjYgYXQgMTE6MDbigK9BTSBKZWZmIExheXRvbiA8amxheXRvbkBr
ZXJuZWwub3JnPiB3cm90ZToKPgo+IFVwZGF0ZSAlbHUvJWxkIHRvICVsbHUvJWxsZCBpbiBzZWN1
cml0eSBhdWRpdCBsb2dnaW5nIGZ1bmN0aW9ucyB0aGF0Cj4gcHJpbnQgaW5vZGUtPmlfaW5vLCBz
aW5jZSBpX2lubyBpcyBub3cgdTY0Lgo+Cj4gRmlsZXMgdXBkYXRlZDogYXBwYXJtb3IvYXBwYXJt
b3Jmcy5jLCBpbnRlZ3JpdHkvaW50ZWdyaXR5X2F1ZGl0LmMsCj4gaXBlL2F1ZGl0LmMsIGxzbV9h
dWRpdC5jLgo+Cj4gU2lnbmVkLW9mZi1ieTogSmVmZiBMYXl0b24gPGpsYXl0b25Aa2VybmVsLm9y
Zz4KPiAtLS0KPiAgc2VjdXJpdHkvYXBwYXJtb3IvYXBwYXJtb3Jmcy5jICAgICAgIHwgIDQgKyst
LQo+ICBzZWN1cml0eS9pbnRlZ3JpdHkvaW50ZWdyaXR5X2F1ZGl0LmMgfCAgMiArLQo+ICBzZWN1
cml0eS9pcGUvYXVkaXQuYyAgICAgICAgICAgICAgICAgfCAgMiArLQo+ICBzZWN1cml0eS9sc21f
YXVkaXQuYyAgICAgICAgICAgICAgICAgfCAxMCArKysrKy0tLS0tCj4gIHNlY3VyaXR5L3NlbGlu
dXgvaG9va3MuYyAgICAgICAgICAgICB8ICA0ICsrLS0KPiAgc2VjdXJpdHkvc21hY2svc21hY2tf
bHNtLmMgICAgICAgICAgIHwgMTIgKysrKysrLS0tLS0tCj4gIDYgZmlsZXMgY2hhbmdlZCwgMTcg
aW5zZXJ0aW9ucygrKSwgMTcgZGVsZXRpb25zKC0pCgouLi4KCj4gZGlmZiAtLWdpdCBhL3NlY3Vy
aXR5L2xzbV9hdWRpdC5jIGIvc2VjdXJpdHkvbHNtX2F1ZGl0LmMKPiBpbmRleCA3ZDYyM2IwMDQ5
NWMxNGIwNzllMTBlOTYzYzIxYTlmOTQ5YzExZjA3Li43MzdmNWEyNjNhOGY3OTQxNjEzMzMxNWVk
ZjM2M2VjZTNkNzljNzIyIDEwMDY0NAo+IC0tLSBhL3NlY3VyaXR5L2xzbV9hdWRpdC5jCj4gKysr
IGIvc2VjdXJpdHkvbHNtX2F1ZGl0LmMKCkV2ZXJ5dGhpbmcgaW4gc2VjdXJpdHkvbHNtX2F1ZGl0
LmMgbG9va3Mgb2theS4KCj4gZGlmZiAtLWdpdCBhL3NlY3VyaXR5L3NlbGludXgvaG9va3MuYyBi
L3NlY3VyaXR5L3NlbGludXgvaG9va3MuYwo+IGluZGV4IGQ4MjI0ZWExMTNkMWFjMjczYWFjMWZi
NTIzMjRmMDBiMzMwMWFlNzUuLjE1MGVhODZlYmMxZjdjN2Y4MzkxYWY0MTA5YTNkYTgyYjEyZDAw
ZDIgMTAwNjQ0Cj4gLS0tIGEvc2VjdXJpdHkvc2VsaW51eC9ob29rcy5jCj4gKysrIGIvc2VjdXJp
dHkvc2VsaW51eC9ob29rcy5jCj4gQEAgLTE0MDAsNyArMTQwMCw3IEBAIHN0YXRpYyBpbnQgaW5v
ZGVfZG9pbml0X3VzZV94YXR0cihzdHJ1Y3QgaW5vZGUgKmlub2RlLCBzdHJ1Y3QgZGVudHJ5ICpk
ZW50cnksCj4gICAgICAgICBpZiAocmMgPCAwKSB7Cj4gICAgICAgICAgICAgICAgIGtmcmVlKGNv
bnRleHQpOwo+ICAgICAgICAgICAgICAgICBpZiAocmMgIT0gLUVOT0RBVEEpIHsKPiAtICAgICAg
ICAgICAgICAgICAgICAgICBwcl93YXJuKCJTRUxpbnV4OiAlczogIGdldHhhdHRyIHJldHVybmVk
ICVkIGZvciBkZXY9JXMgaW5vPSVsZFxuIiwKPiArICAgICAgICAgICAgICAgICAgICAgICBwcl93
YXJuKCJTRUxpbnV4OiAlczogIGdldHhhdHRyIHJldHVybmVkICVkIGZvciBkZXY9JXMgaW5vPSVs
bGRcbiIsCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBfX2Z1bmNfXywgLXJjLCBp
bm9kZS0+aV9zYi0+c19pZCwgaW5vZGUtPmlfaW5vKTsKPiAgICAgICAgICAgICAgICAgICAgICAg
ICByZXR1cm4gcmM7Cj4gICAgICAgICAgICAgICAgIH0KCkFkZGl0aW9uYWxseSwgbGF0ZXIgaW4g
dGhpcyBmdW5jdGlvbiB0aGVyZSBhcmUgcHJfbm90aWNlX3JhdGVsaW1pdGVkKCkKYW5kIHByX3dh
cm4oKSBjYWxscyB0aGF0IHByaW50IGlub2RlIG51bWJlcnMgYW5kIG5lZWQgdG8gYmUgdXBkYXRl
ZC4KCi0tIApwYXVsLW1vb3JlLmNvbQoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fCkxpbnV4LWYyZnMtZGV2ZWwgbWFpbGluZyBsaXN0CkxpbnV4LWYyZnMt
ZGV2ZWxAbGlzdHMuc291cmNlZm9yZ2UubmV0Cmh0dHBzOi8vbGlzdHMuc291cmNlZm9yZ2UubmV0
L2xpc3RzL2xpc3RpbmZvL2xpbnV4LWYyZnMtZGV2ZWwK
