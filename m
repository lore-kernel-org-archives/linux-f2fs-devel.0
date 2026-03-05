Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87F9DF30924
	for <linux-f2fs-devel@archiver.kernel.org>; Thu,  5 Mar 2026 09:43:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:In-Reply-To:MIME-Version:References:Message-ID:To:From:Date:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ZVLk7CODn5H9seP+fSIfTdhwJscmr1deyaA0DC2DpXo=; b=Fa0ZxUFxR4k2bvPrqMJ5jX5jOD
	a3ZTdgpW5F6ytnnm0cy3/FEDJGY0+y9MEFhUQeaS14SqSBkaBx8KC3K5WWAAzqqv+zIhkDmFDJhDL
	J2LVbVfkrITPlLpaNhjxJQW3XjVIYJSR2DBBTNttCo36d9aDR8JU8BDrmwu9trYWJXRc=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1vy5FB-00061H-T8;
	Thu, 05 Mar 2026 09:43:45 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <jack@suse.cz>) id 1vy5F9-000619-Bq
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 05 Mar 2026 09:43:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=2wZ6WM2agme4KB7OO9Uj9Ti918saQbdVqI8KEDL2UEs=; b=JUh51/G53FRsjqFFU8Z97nTL2L
 aZ+cePVrau8etEj2O1x2OdhPl/h5JIVp0sJ2ba5PnAfeujjKQ4WdXVVjQDuQrlXgo7onOBtHc91Lf
 Kp8oqTjJnvK6gHffuPtPPHafchV7Tlu70Oxv9vKLgNN98VW2+N3QA4ALJP1FciXRC/vU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=2wZ6WM2agme4KB7OO9Uj9Ti918saQbdVqI8KEDL2UEs=; b=KN+LypLOpK1koWOjxeChwp6FzZ
 NALxcpaa4fbMEW2eQYTBlqZx+J5KwEp3enoGsg0vOgxfheQ2hvMKopQtBxpntQ/IwUuCubyPAXEvr
 IXDd3Dt/WuAEvZ3rdVyCdwVmcehUCQ0X/kwGz8uW0zuU5N2hfui0keqxnID6s8BbDrvY=;
Received: from smtp-out2.suse.de ([195.135.223.131])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1vy5F6-0005cM-S3 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 05 Mar 2026 09:43:43 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id B3E155BD7C;
 Thu,  5 Mar 2026 09:43:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1772703813; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2wZ6WM2agme4KB7OO9Uj9Ti918saQbdVqI8KEDL2UEs=;
 b=H26GTXbiZRBvCVDcZRwbJk66w1ixYW4VwRX+spRUz7+P7iOWrclqmkrVfqedbo/gScVx4U
 MAwBKZWYvJfnSO0QySBY3WxGnhZ95K57kNNbnrvpTbtIYGOPKwBiixWm2hkpDM1K2TUVfm
 sngI7+/YwHNgSyP0HIBwXhVEH0NhDHI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1772703813;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2wZ6WM2agme4KB7OO9Uj9Ti918saQbdVqI8KEDL2UEs=;
 b=S07bafX3PGMordajZJInB6bdGk2uZp7AFDx0lXaGoT2ltOu1YVbtOoqJ7DuIHW8OdFfsFt
 e/JCFNI1J7Q4sCCQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=H26GTXbi;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=S07bafX3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1772703813; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2wZ6WM2agme4KB7OO9Uj9Ti918saQbdVqI8KEDL2UEs=;
 b=H26GTXbiZRBvCVDcZRwbJk66w1ixYW4VwRX+spRUz7+P7iOWrclqmkrVfqedbo/gScVx4U
 MAwBKZWYvJfnSO0QySBY3WxGnhZ95K57kNNbnrvpTbtIYGOPKwBiixWm2hkpDM1K2TUVfm
 sngI7+/YwHNgSyP0HIBwXhVEH0NhDHI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1772703813;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2wZ6WM2agme4KB7OO9Uj9Ti918saQbdVqI8KEDL2UEs=;
 b=S07bafX3PGMordajZJInB6bdGk2uZp7AFDx0lXaGoT2ltOu1YVbtOoqJ7DuIHW8OdFfsFt
 e/JCFNI1J7Q4sCCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 97E0D3EA78;
 Thu,  5 Mar 2026 09:43:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id GwBmJEVQqWlvPQAAD6G6ig
 (envelope-from <jack@suse.cz>); Thu, 05 Mar 2026 09:43:33 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
 id 38D1EA0AB1; Thu,  5 Mar 2026 10:43:33 +0100 (CET)
Date: Thu, 5 Mar 2026 10:43:33 +0100
From: Jan Kara <jack@suse.cz>
To: Jeff Layton <jlayton@kernel.org>
Message-ID: <cqggd22cce6p4ocnjpq5yfszaxgdejph5na7xmg3tmfuupoev4@zk5lntahee5b>
References: <20260304-iino-u64-v3-0-2257ad83d372@kernel.org>
 <20260304-iino-u64-v3-4-2257ad83d372@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260304-iino-u64-v3-4-2257ad83d372@kernel.org>
X-Spamd-Bar: /
X-Rspamd-Queue-Id: B3E155BD7C
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-0.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 FORGED_RECIPIENTS(2.00)[m:jlayton@kernel.org, m:viro@zeniv.linux.org.uk,
 m:brauner@kernel.org, m:rostedt@goodmis.org, m:mhiramat@kernel.org,
 m:mathieu.desnoyers@efficios.com, m:dan.j.williams@intel.com,
 m:ebiggers@kernel.org, m:muchun.song@linux.dev, m:david@kernel.org,
 m:adilger.kernel@dilger.ca, m:jaegeuk@kernel.org, m:chao@kernel.org,
 m:trondmy@kernel.org, m:anna@kernel.org, m:neil@brown.name,
 m:ronniesahlberg@gmail.com, m:alex.aring@gmail.com,
 m:konishi.ryusuke@gmail.com, m:slava@dubeyko.com, m:ericvh@kernel.org,
 m:lucho@ionkov.net, m:asmadeus@codewreck.org, m:linux_oss@crudebyte.com,
 m:marc.dionne@auristor.com, m:luisbg@kernel.org, m:salah.triki@gmail.com,
 m:aivazian.tigran@gmail.com, m:idryomov@gmail.com, m:jaharkes@cs.cmu.edu,
 m:coda@cs.cmu.edu, m:nico@fluxnic.net, m:amir73il@gmail.com,
 m:hch@infradead.org, m:frank.li@vivo.com, m:mikulas@artax.karlin.mff.cuni.cz,
 m:dwmw2@infradead.org, m:shaggy@kernel.org, m:mark@fasheh.com,
 m:jlbec@evilplan.org, m:joseph.qi@linux.alibaba.com, m:al@alarsen.net,
 m:chengzhihao1@huawei.
 com, m:dlemoal@kernel.org, m:naohiro.aota@wdc.com, m:jth@kernel.org,
 m:john.johansen@canonical.com, m:serge@hallyn.com, m:zohar@linux.ibm.com,
 m:roberto.sassu@huawei.com, m:dmitry.kasatkin@gmail.com, m:wufan@kernel.org,
 m:stephen.smalley.work@gmail.com, m:alexander.deucher@amd.com,
 m:christian.koenig@amd.com, m:airlied@gmail.com, m:simona@ffwll.ch,
 m:sumit.semwal@linaro.org, m:edumazet@google.com, m:kuniyu@google.com,
 m:willemb@google.com, m:davem@davemloft.net, m:kuba@kernel.org,
 m:horms@kernel.org, m:peterz@infradead.org, m:acme@kernel.org,
 m:namhyung@kernel.org, m:mark.rutland@arm.com, s:ocfs2-devel@lists.linux.dev,
 s:v9fs@lists.linux.dev, s:devel@lists.orangefs.org,
 s:samba-technical@lists.samba.org, s:jfs-discussion@lists.sourceforge.net,
 s:linux-f2fs-devel@lists.sourceforge.net, s:apparmor@lists.ubuntu.com,
 s:mkl@pengutronix.de, s:eparis@redhat.com, s:steffen.klassert@secunet.com,
 s:audit@vger.kernel.org, s:autofs@vger.kernel.org, s:bpf@vger.kernel.org,
 s:ceph-devel@vger.kernel.org, s:ecryptfs@vger.kernel.org, s:linu
 x-bluetooth@vger.kernel.org,s:linux-can@vger.kernel.org,s:linux-cifs@vger.kernel.org,s:linux-ext4@vger.kernel.org];
 SUSPICIOUS_RECIPS(1.50)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_TLS_LAST(0.00)[]; RCVD_COUNT_THREE(0.00)[3];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 TO_DN_SOME(0.00)[]; ARC_NA(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; MIME_TRACE(0.00)[0:+];
 FROM_HAS_DN(0.00)[];
 FREEMAIL_CC(0.00)[zeniv.linux.org.uk, kernel.org, suse.cz, goodmis.org,
 efficios.com, intel.com, mit.edu, linux.dev, suse.de, redhat.com,
 manguebit.org, dilger.ca, suse.com, oracle.com, brown.name, talpey.com,
 samba.org, gmail.com, microsoft.com, dubeyko.com, ionkov.net, codewreck.org,
 crudebyte.com, auristor.com, themaw.net, cs.cmu.edu, fluxnic.net, tyhicks.com,
 infradead.org, physik.fu-berlin.de, vivo.com, artax.karlin.mff.cuni.cz, nod.at,
 paragon-software.com, fasheh.com, evilplan.org, linux.alibaba.com,
 omnibond.com, szeredi.hu, alarsen.net, huawei.com, wdc.com, canonical.com,
 paul-moore.com, namei.org, hallyn.com, linux.ibm.com, schaufler-ca.com,
 amd.com, ffwll.ch, linaro.org, google.com, davemloft.net, arm.com,
 linux.intel.com, dev.tdt.de, yaina.de, holtmann.org, hartkopp.net,
 pengutronix.de, secunet.com, gondor.apana.org.au, fomichev.me, iogearbox.net,
 vger.kernel.org, lists.linux.dev, kvack.org, lists.sourceforge.net,
 lists.samba.org, lists.infradead.org, coda.cs.cmu.edu, lists.orangefs.org,
 lists.ubuntu.com, lists.freedesktop.org, lists.linaro.or g];
 RCPT_COUNT_GT_50(0.00)[171];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 TO_MATCH_ENVRCPT_SOME(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TAGGED_RCPT(0.00)[]; MISSING_XM_UA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; DKIM_TRACE(0.00)[suse.cz:+];
 R_RATELIMIT(0.00)[to_ip_from(RLswj4uqt94acu18q19g37moup)];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email]
X-Headers-End: 1vy5F6-0005cM-S3
Subject: Re: [f2fs-dev] [PATCH v3 04/12] vfs: widen trace event i_ino fields
 to u64
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
 linux-sctp@vger.kernel.org, linux-hams@vger.kernel.org,
 Sumit Semwal <sumit.semwal@linaro.org>, Mike Marshall <hubcap@omnibond.com>,
 linux-xfs@vger.kernel.org, Fan Wu <wufan@kernel.org>,
 Xin Long <lucien.xin@gmail.com>, ceph-devel@vger.kernel.org,
 James Morris <jmorris@namei.org>, Tyler Hicks <code@tyhicks.com>,
 Christoph Hellwig <hch@infradead.org>, devel@lists.orangefs.org,
 Shyam Prasad N <sprasad@microsoft.com>, Martin Schiller <ms@dev.tdt.de>,
 Jesper Dangaard Brouer <hawk@kernel.org>, Jan Harkes <jaharkes@cs.cmu.edu>,
 Willem de Bruijn <willemb@google.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>, linux-fscrypt@vger.kernel.org,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Ronnie Sahlberg <ronniesahlberg@gmail.com>,
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 David Hildenbrand <david@kernel.org>, Eric Van Hensbergen <ericvh@kernel.org>,
 Magnus Karlsson <magnus.karlsson@intel.com>,
 Christian Brauner <brauner@kernel.org>,
 Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
 Stephen Smalley <stephen.smalley.work@gmail.com>, linux-kernel@vger.kernel.org,
 Eric Paris <eparis@redhat.com>, linux-perf-users@vger.kernel.org,
 Chuck Lever <chuck.lever@oracle.com>, Masami Hiramatsu <mhiramat@kernel.org>,
 Jiri Olsa <jolsa@kernel.org>, Jan Kara <jack@suse.com>,
 Alex Deucher <alexander.deucher@amd.com>, linux-media@vger.kernel.org,
 Trond Myklebust <trondmy@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Dave Kleikamp <shaggy@kernel.org>, Mimi Zohar <zohar@linux.ibm.com>,
 Oleg Nesterov <oleg@redhat.com>, Eric Dumazet <edumazet@google.com>,
 Johan Hedberg <johan.hedberg@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-cifs@vger.kernel.org, Kuniyuki Iwashima <kuniyu@google.com>,
 linux-nilfs@vger.kernel.org, Paul Moore <paul@paul-moore.com>,
 John Fastabend <john.fastabend@gmail.com>, codalist@coda.cs.cmu.edu,
 Remi Denis-Courmont <courmisch@gmail.com>, linux-trace-kernel@vger.kernel.org,
 Olga Kornievskaia <okorniev@redhat.com>,
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
 Yangtao Li <frank.li@vivo.com>, selinux@vger.kernel.org, v9fs@lists.linux.dev,
 linux-can@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
 Casey Schaufler <casey@schaufler-ca.com>, netfs@lists.linux.dev,
 Jaegeuk Kim <jaegeuk@kernel.org>, fsverity@lists.linux.dev,
 "Theodore Y. Ts'o" <tytso@mit.edu>, Nicolas Pitre <nico@fluxnic.net>,
 Muchun Song <muchun.song@linux.dev>, Roberto Sassu <roberto.sassu@huawei.com>,
 "David S. Miller" <davem@davemloft.net>, Anna Schumaker <anna@kernel.org>,
 linux-integrity@vger.kernel.org,
 Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 Alex Markuze <amarkuze@redhat.com>, Martin Brandenburg <martin@omnibond.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 ocfs2-devel@lists.linux.dev, Alexei Starovoitov <ast@kernel.org>,
 linux-mtd@lists.infradead.org, Marc Dionne <marc.dionne@auristor.com>,
 Neal Cardwell <ncardwell@google.com>, linux-afs@lists.infradead.org,
 Ian Kent <raven@themaw.net>, Naohiro Aota <naohiro.aota@wdc.com>,
 Eric Biggers <ebiggers@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Miklos Szeredi <miklos@szeredi.hu>, amd-gfx@lists.freedesktop.org,
 coda@cs.cmu.edu, Stanislav Fomichev <sdf@fomichev.me>,
 Viacheslav Dubeyko <slava@dubeyko.com>, NeilBrown <neil@brown.name>,
 Ilya Dryomov <idryomov@gmail.com>, Paolo Abeni <pabeni@redhat.com>,
 jfs-discussion@lists.sourceforge.net, "Serge E. Hallyn" <serge@hallyn.com>,
 Amir Goldstein <amir73il@gmail.com>, James Clark <james.clark@linaro.org>,
 autofs@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
 Damien Le Moal <dlemoal@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Dan Williams <dan.j.williams@intel.com>, Oscar Salvador <osalvador@suse.de>,
 Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
 linux-nfs@vger.kernel.org, linux-ext4@vger.kernel.org, linux-mm@kvack.org,
 samba-technical@lists.samba.org, Ondrej Mosnacek <omosnace@redhat.com>,
 Steve French <sfrench@samba.org>, netdev@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, bpf@vger.kernel.org, ntfs3@lists.linux.dev,
 Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
 Ian Rogers <irogers@google.com>, Alexander Aring <alex.aring@gmail.com>,
 Jan Kara <jack@suse.cz>, Peter Zijlstra <peterz@infradead.org>,
 Dominique Martinet <asmadeus@codewreck.org>,
 Christian Schoenebeck <linux_oss@crudebyte.com>, ecryptfs@vger.kernel.org,
 linux-unionfs@vger.kernel.org, David Howells <dhowells@redhat.com>,
 Joseph Qi <joseph.qi@linux.alibaba.com>,
 Andreas Dilger <adilger.kernel@dilger.ca>,
 Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>,
 linux-f2fs-devel@lists.sourceforge.net, David Airlie <airlied@gmail.com>,
 Steffen Klassert <steffen.klassert@secunet.com>,
 Eric Snowberg <eric.snowberg@oracle.com>,
 Herbert Xu <herbert@gondor.apana.org.au>, linux-x25@vger.kernel.org,
 linux-bluetooth@vger.kernel.org, Richard Weinberger <richard@nod.at>,
 Mark Fasheh <mark@fasheh.com>, Dai Ngo <Dai.Ngo@oracle.com>,
 Ingo Molnar <mingo@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
 Salah Triki <salah.triki@gmail.com>, Marcel Holtmann <marcel@holtmann.org>,
 Joerg Reuter <jreuter@yaina.de>, Simon Horman <horms@kernel.org>,
 apparmor@lists.ubuntu.com, Tom Talpey <tom@talpey.com>,
 Bharath SM <bharathsm@microsoft.com>, Marc Kleine-Budde <mkl@pengutronix.de>,
 "Tigran A. Aivazian" <aivazian.tigran@gmail.com>,
 David Sterba <dsterba@suse.com>, Namhyung Kim <namhyung@kernel.org>,
 Ryusuke Konishi <konishi.ryusuke@gmail.com>,
 John Johansen <john.johansen@canonical.com>,
 Luis de Bethencourt <luisbg@kernel.org>,
 Oliver Hartkopp <socketcan@hartkopp.net>, David Ahern <dsahern@kernel.org>,
 Adrian Hunter <adrian.hunter@intel.com>, audit@vger.kernel.org,
 linux-security-module@vger.kernel.org, Johannes Thumshirn <jth@kernel.org>,
 David Woodhouse <dwmw2@infradead.org>, Joel Becker <jlbec@evilplan.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Wed 04-03-26 10:32:34, Jeff Layton wrote:
> Update VFS-layer trace event definitions to use u64 instead of
> ino_t/unsigned long for inode number fields. Update TP_printk format
> strings to use %llu/%llx to match the widened field type. Remove
> now-unnecessary (unsigned long) casts since __entry->ino is already
> u64.
> 
> Signed-off-by: Jeff Layton <jlayton@kernel.org>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/iomap/trace.h                 |   8 +-
>  include/trace/events/filelock.h  |  34 ++++----
>  include/trace/events/filemap.h   |  20 ++---
>  include/trace/events/fs_dax.h    |  20 ++---
>  include/trace/events/fsverity.h  |  30 ++++----
>  include/trace/events/netfs.h     |   8 +-
>  include/trace/events/readahead.h |  18 ++---
>  include/trace/events/timestamp.h |  16 ++--
>  include/trace/events/writeback.h | 162 +++++++++++++++++++--------------------
>  9 files changed, 158 insertions(+), 158 deletions(-)
> 
> diff --git a/fs/iomap/trace.h b/fs/iomap/trace.h
> index 532787277b168e881759d521cd3559ec65979152..097773c6db80e289bb488ef2af6e29f0d777b102 100644
> --- a/fs/iomap/trace.h
> +++ b/fs/iomap/trace.h
> @@ -257,7 +257,7 @@ TRACE_EVENT(iomap_dio_rw_begin,
>  	TP_ARGS(iocb, iter, dio_flags, done_before),
>  	TP_STRUCT__entry(
>  		__field(dev_t,	dev)
> -		__field(ino_t,	ino)
> +		__field(u64,	ino)
>  		__field(loff_t, isize)
>  		__field(loff_t, pos)
>  		__field(size_t,	count)
> @@ -277,7 +277,7 @@ TRACE_EVENT(iomap_dio_rw_begin,
>  		__entry->dio_flags = dio_flags;
>  		__entry->aio = !is_sync_kiocb(iocb);
>  	),
> -	TP_printk("dev %d:%d ino 0x%lx size 0x%llx offset 0x%llx length 0x%zx done_before 0x%zx flags %s dio_flags %s aio %d",
> +	TP_printk("dev %d:%d ino 0x%llx size 0x%llx offset 0x%llx length 0x%zx done_before 0x%zx flags %s dio_flags %s aio %d",
>  		  MAJOR(__entry->dev), MINOR(__entry->dev),
>  		  __entry->ino,
>  		  __entry->isize,
> @@ -294,7 +294,7 @@ TRACE_EVENT(iomap_dio_complete,
>  	TP_ARGS(iocb, error, ret),
>  	TP_STRUCT__entry(
>  		__field(dev_t,	dev)
> -		__field(ino_t,	ino)
> +		__field(u64,	ino)
>  		__field(loff_t, isize)
>  		__field(loff_t, pos)
>  		__field(int,	ki_flags)
> @@ -312,7 +312,7 @@ TRACE_EVENT(iomap_dio_complete,
>  		__entry->error = error;
>  		__entry->ret = ret;
>  	),
> -	TP_printk("dev %d:%d ino 0x%lx size 0x%llx offset 0x%llx flags %s aio %d error %d ret %zd",
> +	TP_printk("dev %d:%d ino 0x%llx size 0x%llx offset 0x%llx flags %s aio %d error %d ret %zd",
>  		  MAJOR(__entry->dev), MINOR(__entry->dev),
>  		  __entry->ino,
>  		  __entry->isize,
> diff --git a/include/trace/events/filelock.h b/include/trace/events/filelock.h
> index 370016c38a5bbc07d5ba6c102030b49c9eb6424d..1167748862449ef6ff04c40b568ea8c3bbb08207 100644
> --- a/include/trace/events/filelock.h
> +++ b/include/trace/events/filelock.h
> @@ -42,10 +42,10 @@ TRACE_EVENT(locks_get_lock_context,
>  	TP_ARGS(inode, type, ctx),
>  
>  	TP_STRUCT__entry(
> -		__field(unsigned long, i_ino)
> +		__field(u64, i_ino)
> +		__field(struct file_lock_context *, ctx)
>  		__field(dev_t, s_dev)
>  		__field(unsigned char, type)
> -		__field(struct file_lock_context *, ctx)
>  	),
>  
>  	TP_fast_assign(
> @@ -55,7 +55,7 @@ TRACE_EVENT(locks_get_lock_context,
>  		__entry->ctx = ctx;
>  	),
>  
> -	TP_printk("dev=0x%x:0x%x ino=0x%lx type=%s ctx=%p",
> +	TP_printk("dev=0x%x:0x%x ino=0x%llx type=%s ctx=%p",
>  		  MAJOR(__entry->s_dev), MINOR(__entry->s_dev),
>  		  __entry->i_ino, show_fl_type(__entry->type), __entry->ctx)
>  );
> @@ -66,16 +66,16 @@ DECLARE_EVENT_CLASS(filelock_lock,
>  	TP_ARGS(inode, fl, ret),
>  
>  	TP_STRUCT__entry(
> +		__field(u64, i_ino)
> +		__field(loff_t, fl_start)
> +		__field(loff_t, fl_end)
>  		__field(struct file_lock *, fl)
> -		__field(unsigned long, i_ino)
> -		__field(dev_t, s_dev)
>  		__field(struct file_lock_core *, blocker)
>  		__field(fl_owner_t, owner)
> +		__field(dev_t, s_dev)
>  		__field(unsigned int, pid)
>  		__field(unsigned int, flags)
>  		__field(unsigned char, type)
> -		__field(loff_t, fl_start)
> -		__field(loff_t, fl_end)
>  		__field(int, ret)
>  	),
>  
> @@ -93,7 +93,7 @@ DECLARE_EVENT_CLASS(filelock_lock,
>  		__entry->ret = ret;
>  	),
>  
> -	TP_printk("fl=%p dev=0x%x:0x%x ino=0x%lx fl_blocker=%p fl_owner=%p fl_pid=%u fl_flags=%s fl_type=%s fl_start=%lld fl_end=%lld ret=%d",
> +	TP_printk("fl=%p dev=0x%x:0x%x ino=0x%llx fl_blocker=%p fl_owner=%p fl_pid=%u fl_flags=%s fl_type=%s fl_start=%lld fl_end=%lld ret=%d",
>  		__entry->fl, MAJOR(__entry->s_dev), MINOR(__entry->s_dev),
>  		__entry->i_ino, __entry->blocker, __entry->owner,
>  		__entry->pid, show_fl_flags(__entry->flags),
> @@ -123,15 +123,15 @@ DECLARE_EVENT_CLASS(filelock_lease,
>  	TP_ARGS(inode, fl),
>  
>  	TP_STRUCT__entry(
> +		__field(u64, i_ino)
>  		__field(struct file_lease *, fl)
> -		__field(unsigned long, i_ino)
> -		__field(dev_t, s_dev)
>  		__field(struct file_lock_core *, blocker)
>  		__field(fl_owner_t, owner)
> -		__field(unsigned int, flags)
> -		__field(unsigned char, type)
>  		__field(unsigned long, break_time)
>  		__field(unsigned long, downgrade_time)
> +		__field(dev_t, s_dev)
> +		__field(unsigned int, flags)
> +		__field(unsigned char, type)
>  	),
>  
>  	TP_fast_assign(
> @@ -146,7 +146,7 @@ DECLARE_EVENT_CLASS(filelock_lease,
>  		__entry->downgrade_time = fl ? fl->fl_downgrade_time : 0;
>  	),
>  
> -	TP_printk("fl=%p dev=0x%x:0x%x ino=0x%lx fl_blocker=%p fl_owner=%p fl_flags=%s fl_type=%s fl_break_time=%lu fl_downgrade_time=%lu",
> +	TP_printk("fl=%p dev=0x%x:0x%x ino=0x%llx fl_blocker=%p fl_owner=%p fl_flags=%s fl_type=%s fl_break_time=%lu fl_downgrade_time=%lu",
>  		__entry->fl, MAJOR(__entry->s_dev), MINOR(__entry->s_dev),
>  		__entry->i_ino, __entry->blocker, __entry->owner,
>  		show_fl_flags(__entry->flags),
> @@ -175,12 +175,12 @@ TRACE_EVENT(generic_add_lease,
>  	TP_ARGS(inode, fl),
>  
>  	TP_STRUCT__entry(
> -		__field(unsigned long, i_ino)
> +		__field(u64, i_ino)
> +		__field(fl_owner_t, owner)
> +		__field(dev_t, s_dev)
>  		__field(int, wcount)
>  		__field(int, rcount)
>  		__field(int, icount)
> -		__field(dev_t, s_dev)
> -		__field(fl_owner_t, owner)
>  		__field(unsigned int, flags)
>  		__field(unsigned char, type)
>  	),
> @@ -196,7 +196,7 @@ TRACE_EVENT(generic_add_lease,
>  		__entry->type = fl->c.flc_type;
>  	),
>  
> -	TP_printk("dev=0x%x:0x%x ino=0x%lx wcount=%d rcount=%d icount=%d fl_owner=%p fl_flags=%s fl_type=%s",
> +	TP_printk("dev=0x%x:0x%x ino=0x%llx wcount=%d rcount=%d icount=%d fl_owner=%p fl_flags=%s fl_type=%s",
>  		MAJOR(__entry->s_dev), MINOR(__entry->s_dev),
>  		__entry->i_ino, __entry->wcount, __entry->rcount,
>  		__entry->icount, __entry->owner,
> diff --git a/include/trace/events/filemap.h b/include/trace/events/filemap.h
> index f48fe637bfd25885dc6daaf09336ab60626b4944..4dcf8e9e2e0d8bde7c9df9856c059d2cdebff59f 100644
> --- a/include/trace/events/filemap.h
> +++ b/include/trace/events/filemap.h
> @@ -20,8 +20,8 @@ DECLARE_EVENT_CLASS(mm_filemap_op_page_cache,
>  	TP_ARGS(folio),
>  
>  	TP_STRUCT__entry(
> +		__field(u64, i_ino)
>  		__field(unsigned long, pfn)
> -		__field(unsigned long, i_ino)
>  		__field(unsigned long, index)
>  		__field(dev_t, s_dev)
>  		__field(unsigned char, order)
> @@ -38,7 +38,7 @@ DECLARE_EVENT_CLASS(mm_filemap_op_page_cache,
>  		__entry->order = folio_order(folio);
>  	),
>  
> -	TP_printk("dev %d:%d ino %lx pfn=0x%lx ofs=%lu order=%u",
> +	TP_printk("dev %d:%d ino %llx pfn=0x%lx ofs=%lu order=%u",
>  		MAJOR(__entry->s_dev), MINOR(__entry->s_dev),
>  		__entry->i_ino,
>  		__entry->pfn,
> @@ -67,7 +67,7 @@ DECLARE_EVENT_CLASS(mm_filemap_op_page_cache_range,
>  	TP_ARGS(mapping, index, last_index),
>  
>  	TP_STRUCT__entry(
> -		__field(unsigned long, i_ino)
> +		__field(u64, i_ino)
>  		__field(dev_t, s_dev)
>  		__field(unsigned long, index)
>  		__field(unsigned long, last_index)
> @@ -85,7 +85,7 @@ DECLARE_EVENT_CLASS(mm_filemap_op_page_cache_range,
>  	),
>  
>  	TP_printk(
> -		"dev=%d:%d ino=%lx ofs=%lld-%lld",
> +		"dev=%d:%d ino=%llx ofs=%lld-%lld",
>  		MAJOR(__entry->s_dev),
>  		MINOR(__entry->s_dev), __entry->i_ino,
>  		((loff_t)__entry->index) << PAGE_SHIFT,
> @@ -117,7 +117,7 @@ TRACE_EVENT(mm_filemap_fault,
>  	TP_ARGS(mapping, index),
>  
>  	TP_STRUCT__entry(
> -		__field(unsigned long, i_ino)
> +		__field(u64, i_ino)
>  		__field(dev_t, s_dev)
>  		__field(unsigned long, index)
>  	),
> @@ -133,7 +133,7 @@ TRACE_EVENT(mm_filemap_fault,
>  	),
>  
>  	TP_printk(
> -		"dev=%d:%d ino=%lx ofs=%lld",
> +		"dev=%d:%d ino=%llx ofs=%lld",
>  		MAJOR(__entry->s_dev),
>  		MINOR(__entry->s_dev), __entry->i_ino,
>  		((loff_t)__entry->index) << PAGE_SHIFT
> @@ -146,7 +146,7 @@ TRACE_EVENT(filemap_set_wb_err,
>  		TP_ARGS(mapping, eseq),
>  
>  		TP_STRUCT__entry(
> -			__field(unsigned long, i_ino)
> +			__field(u64, i_ino)
>  			__field(dev_t, s_dev)
>  			__field(errseq_t, errseq)
>  		),
> @@ -160,7 +160,7 @@ TRACE_EVENT(filemap_set_wb_err,
>  				__entry->s_dev = mapping->host->i_rdev;
>  		),
>  
> -		TP_printk("dev=%d:%d ino=0x%lx errseq=0x%x",
> +		TP_printk("dev=%d:%d ino=0x%llx errseq=0x%x",
>  			MAJOR(__entry->s_dev), MINOR(__entry->s_dev),
>  			__entry->i_ino, __entry->errseq)
>  );
> @@ -171,8 +171,8 @@ TRACE_EVENT(file_check_and_advance_wb_err,
>  		TP_ARGS(file, old),
>  
>  		TP_STRUCT__entry(
> +			__field(u64, i_ino)
>  			__field(struct file *, file)
> -			__field(unsigned long, i_ino)
>  			__field(dev_t, s_dev)
>  			__field(errseq_t, old)
>  			__field(errseq_t, new)
> @@ -191,7 +191,7 @@ TRACE_EVENT(file_check_and_advance_wb_err,
>  			__entry->new = file->f_wb_err;
>  		),
>  
> -		TP_printk("file=%p dev=%d:%d ino=0x%lx old=0x%x new=0x%x",
> +		TP_printk("file=%p dev=%d:%d ino=0x%llx old=0x%x new=0x%x",
>  			__entry->file, MAJOR(__entry->s_dev),
>  			MINOR(__entry->s_dev), __entry->i_ino, __entry->old,
>  			__entry->new)
> diff --git a/include/trace/events/fs_dax.h b/include/trace/events/fs_dax.h
> index 50ebc1290ab062a9c30ab00049fb96691f9a0f23..11121baa8ece7928c653b4f874fb10ffbdd02fd0 100644
> --- a/include/trace/events/fs_dax.h
> +++ b/include/trace/events/fs_dax.h
> @@ -12,7 +12,7 @@ DECLARE_EVENT_CLASS(dax_pmd_fault_class,
>  		pgoff_t max_pgoff, int result),
>  	TP_ARGS(inode, vmf, max_pgoff, result),
>  	TP_STRUCT__entry(
> -		__field(unsigned long, ino)
> +		__field(u64, ino)
>  		__field(unsigned long, vm_start)
>  		__field(unsigned long, vm_end)
>  		__field(vm_flags_t, vm_flags)
> @@ -35,7 +35,7 @@ DECLARE_EVENT_CLASS(dax_pmd_fault_class,
>  		__entry->max_pgoff = max_pgoff;
>  		__entry->result = result;
>  	),
> -	TP_printk("dev %d:%d ino %#lx %s %s address %#lx vm_start "
> +	TP_printk("dev %d:%d ino %#llx %s %s address %#lx vm_start "
>  			"%#lx vm_end %#lx pgoff %#lx max_pgoff %#lx %s",
>  		MAJOR(__entry->dev),
>  		MINOR(__entry->dev),
> @@ -66,7 +66,7 @@ DECLARE_EVENT_CLASS(dax_pmd_load_hole_class,
>  		void *radix_entry),
>  	TP_ARGS(inode, vmf, zero_folio, radix_entry),
>  	TP_STRUCT__entry(
> -		__field(unsigned long, ino)
> +		__field(u64, ino)
>  		__field(vm_flags_t, vm_flags)
>  		__field(unsigned long, address)
>  		__field(struct folio *, zero_folio)
> @@ -81,7 +81,7 @@ DECLARE_EVENT_CLASS(dax_pmd_load_hole_class,
>  		__entry->zero_folio = zero_folio;
>  		__entry->radix_entry = radix_entry;
>  	),
> -	TP_printk("dev %d:%d ino %#lx %s address %#lx zero_folio %p "
> +	TP_printk("dev %d:%d ino %#llx %s address %#lx zero_folio %p "
>  			"radix_entry %#lx",
>  		MAJOR(__entry->dev),
>  		MINOR(__entry->dev),
> @@ -106,7 +106,7 @@ DECLARE_EVENT_CLASS(dax_pte_fault_class,
>  	TP_PROTO(struct inode *inode, struct vm_fault *vmf, int result),
>  	TP_ARGS(inode, vmf, result),
>  	TP_STRUCT__entry(
> -		__field(unsigned long, ino)
> +		__field(u64, ino)
>  		__field(vm_flags_t, vm_flags)
>  		__field(unsigned long, address)
>  		__field(pgoff_t, pgoff)
> @@ -123,7 +123,7 @@ DECLARE_EVENT_CLASS(dax_pte_fault_class,
>  		__entry->pgoff = vmf->pgoff;
>  		__entry->result = result;
>  	),
> -	TP_printk("dev %d:%d ino %#lx %s %s address %#lx pgoff %#lx %s",
> +	TP_printk("dev %d:%d ino %#llx %s %s address %#lx pgoff %#lx %s",
>  		MAJOR(__entry->dev),
>  		MINOR(__entry->dev),
>  		__entry->ino,
> @@ -150,7 +150,7 @@ DECLARE_EVENT_CLASS(dax_writeback_range_class,
>  	TP_PROTO(struct inode *inode, pgoff_t start_index, pgoff_t end_index),
>  	TP_ARGS(inode, start_index, end_index),
>  	TP_STRUCT__entry(
> -		__field(unsigned long, ino)
> +		__field(u64, ino)
>  		__field(pgoff_t, start_index)
>  		__field(pgoff_t, end_index)
>  		__field(dev_t, dev)
> @@ -161,7 +161,7 @@ DECLARE_EVENT_CLASS(dax_writeback_range_class,
>  		__entry->start_index = start_index;
>  		__entry->end_index = end_index;
>  	),
> -	TP_printk("dev %d:%d ino %#lx pgoff %#lx-%#lx",
> +	TP_printk("dev %d:%d ino %#llx pgoff %#lx-%#lx",
>  		MAJOR(__entry->dev),
>  		MINOR(__entry->dev),
>  		__entry->ino,
> @@ -182,7 +182,7 @@ TRACE_EVENT(dax_writeback_one,
>  	TP_PROTO(struct inode *inode, pgoff_t pgoff, pgoff_t pglen),
>  	TP_ARGS(inode, pgoff, pglen),
>  	TP_STRUCT__entry(
> -		__field(unsigned long, ino)
> +		__field(u64, ino)
>  		__field(pgoff_t, pgoff)
>  		__field(pgoff_t, pglen)
>  		__field(dev_t, dev)
> @@ -193,7 +193,7 @@ TRACE_EVENT(dax_writeback_one,
>  		__entry->pgoff = pgoff;
>  		__entry->pglen = pglen;
>  	),
> -	TP_printk("dev %d:%d ino %#lx pgoff %#lx pglen %#lx",
> +	TP_printk("dev %d:%d ino %#llx pgoff %#lx pglen %#lx",
>  		MAJOR(__entry->dev),
>  		MINOR(__entry->dev),
>  		__entry->ino,
> diff --git a/include/trace/events/fsverity.h b/include/trace/events/fsverity.h
> index a8c52f21cbd5eb010c7e7b2fdb8f9de49c8ea326..4477c17e05748360965c4e1840590efe96d6335e 100644
> --- a/include/trace/events/fsverity.h
> +++ b/include/trace/events/fsverity.h
> @@ -16,7 +16,7 @@ TRACE_EVENT(fsverity_enable,
>  		 const struct merkle_tree_params *params),
>  	TP_ARGS(inode, params),
>  	TP_STRUCT__entry(
> -		__field(ino_t, ino)
> +		__field(u64, ino)
>  		__field(u64, data_size)
>  		__field(u64, tree_size)
>  		__field(unsigned int, merkle_block)
> @@ -29,8 +29,8 @@ TRACE_EVENT(fsverity_enable,
>  		__entry->merkle_block = params->block_size;
>  		__entry->num_levels = params->num_levels;
>  	),
> -	TP_printk("ino %lu data_size %llu tree_size %llu merkle_block %u levels %u",
> -		(unsigned long) __entry->ino,
> +	TP_printk("ino %llu data_size %llu tree_size %llu merkle_block %u levels %u",
> +		__entry->ino,
>  		__entry->data_size,
>  		__entry->tree_size,
>  		__entry->merkle_block,
> @@ -42,7 +42,7 @@ TRACE_EVENT(fsverity_tree_done,
>  		 const struct merkle_tree_params *params),
>  	TP_ARGS(inode, vi, params),
>  	TP_STRUCT__entry(
> -		__field(ino_t, ino)
> +		__field(u64, ino)
>  		__field(u64, data_size)
>  		__field(u64, tree_size)
>  		__field(unsigned int, merkle_block)
> @@ -59,8 +59,8 @@ TRACE_EVENT(fsverity_tree_done,
>  		memcpy(__get_dynamic_array(root_hash), vi->root_hash, __get_dynamic_array_len(root_hash));
>  		memcpy(__get_dynamic_array(file_digest), vi->file_digest, __get_dynamic_array_len(file_digest));
>  	),
> -	TP_printk("ino %lu data_size %llu tree_size %lld merkle_block %u levels %u root_hash %s digest %s",
> -		(unsigned long) __entry->ino,
> +	TP_printk("ino %llu data_size %llu tree_size %lld merkle_block %u levels %u root_hash %s digest %s",
> +		__entry->ino,
>  		__entry->data_size,
>  		__entry->tree_size,
>  		__entry->merkle_block,
> @@ -75,7 +75,7 @@ TRACE_EVENT(fsverity_verify_data_block,
>  		 u64 data_pos),
>  	TP_ARGS(inode, params, data_pos),
>  	TP_STRUCT__entry(
> -		__field(ino_t, ino)
> +		__field(u64, ino)
>  		__field(u64, data_pos)
>  		__field(unsigned int, merkle_block)
>  	),
> @@ -84,8 +84,8 @@ TRACE_EVENT(fsverity_verify_data_block,
>  		__entry->data_pos = data_pos;
>  		__entry->merkle_block = params->block_size;
>  	),
> -	TP_printk("ino %lu data_pos %llu merkle_block %u",
> -		(unsigned long) __entry->ino,
> +	TP_printk("ino %llu data_pos %llu merkle_block %u",
> +		__entry->ino,
>  		__entry->data_pos,
>  		__entry->merkle_block)
>  );
> @@ -96,7 +96,7 @@ TRACE_EVENT(fsverity_merkle_hit,
>  		 unsigned int hidx),
>  	TP_ARGS(inode, data_pos, hblock_idx, level, hidx),
>  	TP_STRUCT__entry(
> -		__field(ino_t, ino)
> +		__field(u64, ino)
>  		__field(u64, data_pos)
>  		__field(unsigned long, hblock_idx)
>  		__field(unsigned int, level)
> @@ -109,8 +109,8 @@ TRACE_EVENT(fsverity_merkle_hit,
>  		__entry->level = level;
>  		__entry->hidx = hidx;
>  	),
> -	TP_printk("ino %lu data_pos %llu hblock_idx %lu level %u hidx %u",
> -		(unsigned long) __entry->ino,
> +	TP_printk("ino %llu data_pos %llu hblock_idx %lu level %u hidx %u",
> +		__entry->ino,
>  		__entry->data_pos,
>  		__entry->hblock_idx,
>  		__entry->level,
> @@ -122,7 +122,7 @@ TRACE_EVENT(fsverity_verify_merkle_block,
>  		 unsigned int level, unsigned int hidx),
>  	TP_ARGS(inode, hblock_idx, level, hidx),
>  	TP_STRUCT__entry(
> -		__field(ino_t, ino)
> +		__field(u64, ino)
>  		__field(unsigned long, hblock_idx)
>  		__field(unsigned int, level)
>  		__field(unsigned int, hidx)
> @@ -133,8 +133,8 @@ TRACE_EVENT(fsverity_verify_merkle_block,
>  		__entry->level = level;
>  		__entry->hidx = hidx;
>  	),
> -	TP_printk("ino %lu hblock_idx %lu level %u hidx %u",
> -		(unsigned long) __entry->ino,
> +	TP_printk("ino %llu hblock_idx %lu level %u hidx %u",
> +		__entry->ino,
>  		__entry->hblock_idx,
>  		__entry->level,
>  		__entry->hidx)
> diff --git a/include/trace/events/netfs.h b/include/trace/events/netfs.h
> index 2d366be46a1c30feba5ac2368492d7671687a229..8add6d35e648b789db3dce464faf7db1df151ad0 100644
> --- a/include/trace/events/netfs.h
> +++ b/include/trace/events/netfs.h
> @@ -300,7 +300,7 @@ TRACE_EVENT(netfs_read,
>  		    __field(loff_t,			start)
>  		    __field(size_t,			len)
>  		    __field(enum netfs_read_trace,	what)
> -		    __field(unsigned int,		netfs_inode)
> +		    __field(u64,			netfs_inode)
>  			     ),
>  
>  	    TP_fast_assign(
> @@ -313,7 +313,7 @@ TRACE_EVENT(netfs_read,
>  		    __entry->netfs_inode = rreq->inode->i_ino;
>  			   ),
>  
> -	    TP_printk("R=%08x %s c=%08x ni=%x s=%llx l=%zx sz=%llx",
> +	    TP_printk("R=%08x %s c=%08x ni=%llx s=%llx l=%zx sz=%llx",
>  		      __entry->rreq,
>  		      __print_symbolic(__entry->what, netfs_read_traces),
>  		      __entry->cookie,
> @@ -486,7 +486,7 @@ TRACE_EVENT(netfs_folio,
>  	    TP_ARGS(folio, why),
>  
>  	    TP_STRUCT__entry(
> -		    __field(ino_t,			ino)
> +		    __field(u64,			ino)
>  		    __field(pgoff_t,			index)
>  		    __field(unsigned int,		nr)
>  		    __field(enum netfs_folio_trace,	why)
> @@ -500,7 +500,7 @@ TRACE_EVENT(netfs_folio,
>  		    __entry->nr = folio_nr_pages(folio);
>  			   ),
>  
> -	    TP_printk("i=%05lx ix=%05lx-%05lx %s",
> +	    TP_printk("i=%05llx ix=%05lx-%05lx %s",
>  		      __entry->ino, __entry->index, __entry->index + __entry->nr - 1,
>  		      __print_symbolic(__entry->why, netfs_folio_traces))
>  	    );
> diff --git a/include/trace/events/readahead.h b/include/trace/events/readahead.h
> index 0997ac5eceab1ac2de3b84b9d9d59cc338b9dd2b..087f171e2b02d30f09179d5ed6c27a7e0224370b 100644
> --- a/include/trace/events/readahead.h
> +++ b/include/trace/events/readahead.h
> @@ -18,7 +18,7 @@ TRACE_EVENT(page_cache_ra_unbounded,
>  	TP_ARGS(inode, index, nr_to_read, lookahead_size),
>  
>  	TP_STRUCT__entry(
> -		__field(unsigned long, i_ino)
> +		__field(u64, i_ino)
>  		__field(dev_t, s_dev)
>  		__field(pgoff_t, index)
>  		__field(unsigned long, nr_to_read)
> @@ -34,7 +34,7 @@ TRACE_EVENT(page_cache_ra_unbounded,
>  	),
>  
>  	TP_printk(
> -		"dev=%d:%d ino=%lx index=%lu nr_to_read=%lu lookahead_size=%lu",
> +		"dev=%d:%d ino=%llx index=%lu nr_to_read=%lu lookahead_size=%lu",
>  		MAJOR(__entry->s_dev), MINOR(__entry->s_dev), __entry->i_ino,
>  		__entry->index, __entry->nr_to_read, __entry->lookahead_size
>  	)
> @@ -46,7 +46,7 @@ TRACE_EVENT(page_cache_ra_order,
>  	TP_ARGS(inode, index, ra),
>  
>  	TP_STRUCT__entry(
> -		__field(unsigned long, i_ino)
> +		__field(u64, i_ino)
>  		__field(dev_t, s_dev)
>  		__field(pgoff_t, index)
>  		__field(unsigned int, order)
> @@ -66,7 +66,7 @@ TRACE_EVENT(page_cache_ra_order,
>  	),
>  
>  	TP_printk(
> -		"dev=%d:%d ino=%lx index=%lu order=%u size=%u async_size=%u ra_pages=%u",
> +		"dev=%d:%d ino=%llx index=%lu order=%u size=%u async_size=%u ra_pages=%u",
>  		MAJOR(__entry->s_dev), MINOR(__entry->s_dev), __entry->i_ino,
>  		__entry->index, __entry->order, __entry->size,
>  		__entry->async_size, __entry->ra_pages
> @@ -80,16 +80,16 @@ DECLARE_EVENT_CLASS(page_cache_ra_op,
>  	TP_ARGS(inode, index, ra, req_count),
>  
>  	TP_STRUCT__entry(
> -		__field(unsigned long, i_ino)
> -		__field(dev_t, s_dev)
> +		__field(u64, i_ino)
> +		__field(loff_t, prev_pos)
>  		__field(pgoff_t, index)
> +		__field(unsigned long, req_count)
> +		__field(dev_t, s_dev)
>  		__field(unsigned int, order)
>  		__field(unsigned int, size)
>  		__field(unsigned int, async_size)
>  		__field(unsigned int, ra_pages)
>  		__field(unsigned int, mmap_miss)
> -		__field(loff_t, prev_pos)
> -		__field(unsigned long, req_count)
>  	),
>  
>  	TP_fast_assign(
> @@ -106,7 +106,7 @@ DECLARE_EVENT_CLASS(page_cache_ra_op,
>  	),
>  
>  	TP_printk(
> -		"dev=%d:%d ino=%lx index=%lu req_count=%lu order=%u size=%u async_size=%u ra_pages=%u mmap_miss=%u prev_pos=%lld",
> +		"dev=%d:%d ino=%llx index=%lu req_count=%lu order=%u size=%u async_size=%u ra_pages=%u mmap_miss=%u prev_pos=%lld",
>  		MAJOR(__entry->s_dev), MINOR(__entry->s_dev), __entry->i_ino,
>  		__entry->index, __entry->req_count, __entry->order,
>  		__entry->size, __entry->async_size, __entry->ra_pages,
> diff --git a/include/trace/events/timestamp.h b/include/trace/events/timestamp.h
> index c9e5ec930054887a6a7bae8e487611b5ded33d71..d6503612dddf9c6a2f785fad549fa04adddb06fe 100644
> --- a/include/trace/events/timestamp.h
> +++ b/include/trace/events/timestamp.h
> @@ -18,9 +18,9 @@ DECLARE_EVENT_CLASS(ctime,
>  	TP_ARGS(inode, ctime),
>  
>  	TP_STRUCT__entry(
> -		__field(dev_t,		dev)
> -		__field(ino_t,		ino)
> +		__field(u64,		ino)
>  		__field(time64_t,	ctime_s)
> +		__field(dev_t,		dev)
>  		__field(u32,		ctime_ns)
>  		__field(u32,		gen)
>  	),
> @@ -33,7 +33,7 @@ DECLARE_EVENT_CLASS(ctime,
>  		__entry->ctime_ns	= ctime->tv_nsec;
>  	),
>  
> -	TP_printk("ino=%d:%d:%ld:%u ctime=%lld.%u",
> +	TP_printk("ino=%d:%d:%llu:%u ctime=%lld.%u",
>  		MAJOR(__entry->dev), MINOR(__entry->dev), __entry->ino, __entry->gen,
>  		__entry->ctime_s, __entry->ctime_ns
>  	)
> @@ -58,8 +58,8 @@ TRACE_EVENT(ctime_ns_xchg,
>  	TP_ARGS(inode, old, new, cur),
>  
>  	TP_STRUCT__entry(
> +		__field(u64,		ino)
>  		__field(dev_t,		dev)
> -		__field(ino_t,		ino)
>  		__field(u32,		gen)
>  		__field(u32,		old)
>  		__field(u32,		new)
> @@ -75,7 +75,7 @@ TRACE_EVENT(ctime_ns_xchg,
>  		__entry->cur		= cur;
>  	),
>  
> -	TP_printk("ino=%d:%d:%ld:%u old=%u:%s new=%u cur=%u:%s",
> +	TP_printk("ino=%d:%d:%llu:%u old=%u:%s new=%u cur=%u:%s",
>  		MAJOR(__entry->dev), MINOR(__entry->dev), __entry->ino, __entry->gen,
>  		__entry->old & ~I_CTIME_QUERIED,
>  		__print_flags(__entry->old & I_CTIME_QUERIED, "|", CTIME_QUERIED_FLAGS),
> @@ -93,10 +93,10 @@ TRACE_EVENT(fill_mg_cmtime,
>  	TP_ARGS(inode, ctime, mtime),
>  
>  	TP_STRUCT__entry(
> -		__field(dev_t,		dev)
> -		__field(ino_t,		ino)
> +		__field(u64,		ino)
>  		__field(time64_t,	ctime_s)
>  		__field(time64_t,	mtime_s)
> +		__field(dev_t,		dev)
>  		__field(u32,		ctime_ns)
>  		__field(u32,		mtime_ns)
>  		__field(u32,		gen)
> @@ -112,7 +112,7 @@ TRACE_EVENT(fill_mg_cmtime,
>  		__entry->mtime_ns	= mtime->tv_nsec;
>  	),
>  
> -	TP_printk("ino=%d:%d:%ld:%u ctime=%lld.%u mtime=%lld.%u",
> +	TP_printk("ino=%d:%d:%llu:%u ctime=%lld.%u mtime=%lld.%u",
>  		MAJOR(__entry->dev), MINOR(__entry->dev), __entry->ino, __entry->gen,
>  		__entry->ctime_s, __entry->ctime_ns,
>  		__entry->mtime_s, __entry->mtime_ns
> diff --git a/include/trace/events/writeback.h b/include/trace/events/writeback.h
> index 4d3d8c8f3a1bc3e5ef10fc96e3c6dbbd0cf00c98..e5cd2b80fd29dba9177b8ea7c37d63e50e9f60e2 100644
> --- a/include/trace/events/writeback.h
> +++ b/include/trace/events/writeback.h
> @@ -67,7 +67,7 @@ DECLARE_EVENT_CLASS(writeback_folio_template,
>  
>  	TP_STRUCT__entry (
>  		__array(char, name, 32)
> -		__field(ino_t, ino)
> +		__field(u64, ino)
>  		__field(pgoff_t, index)
>  	),
>  
> @@ -79,9 +79,9 @@ DECLARE_EVENT_CLASS(writeback_folio_template,
>  		__entry->index = folio->index;
>  	),
>  
> -	TP_printk("bdi %s: ino=%lu index=%lu",
> +	TP_printk("bdi %s: ino=%llu index=%lu",
>  		__entry->name,
> -		(unsigned long)__entry->ino,
> +		__entry->ino,
>  		__entry->index
>  	)
>  );
> @@ -108,7 +108,7 @@ DECLARE_EVENT_CLASS(writeback_dirty_inode_template,
>  
>  	TP_STRUCT__entry (
>  		__array(char, name, 32)
> -		__field(ino_t, ino)
> +		__field(u64, ino)
>  		__field(unsigned long, state)
>  		__field(unsigned long, flags)
>  	),
> @@ -123,9 +123,9 @@ DECLARE_EVENT_CLASS(writeback_dirty_inode_template,
>  		__entry->flags		= flags;
>  	),
>  
> -	TP_printk("bdi %s: ino=%lu state=%s flags=%s",
> +	TP_printk("bdi %s: ino=%llu state=%s flags=%s",
>  		__entry->name,
> -		(unsigned long)__entry->ino,
> +		__entry->ino,
>  		show_inode_state(__entry->state),
>  		show_inode_state(__entry->flags)
>  	)
> @@ -155,12 +155,12 @@ DEFINE_EVENT(writeback_dirty_inode_template, writeback_dirty_inode,
>  #ifdef CREATE_TRACE_POINTS
>  #ifdef CONFIG_CGROUP_WRITEBACK
>  
> -static inline ino_t __trace_wb_assign_cgroup(struct bdi_writeback *wb)
> +static inline u64 __trace_wb_assign_cgroup(struct bdi_writeback *wb)
>  {
>  	return cgroup_ino(wb->memcg_css->cgroup);
>  }
>  
> -static inline ino_t __trace_wbc_assign_cgroup(struct writeback_control *wbc)
> +static inline u64 __trace_wbc_assign_cgroup(struct writeback_control *wbc)
>  {
>  	if (wbc->wb)
>  		return __trace_wb_assign_cgroup(wbc->wb);
> @@ -169,12 +169,12 @@ static inline ino_t __trace_wbc_assign_cgroup(struct writeback_control *wbc)
>  }
>  #else	/* CONFIG_CGROUP_WRITEBACK */
>  
> -static inline ino_t __trace_wb_assign_cgroup(struct bdi_writeback *wb)
> +static inline u64 __trace_wb_assign_cgroup(struct bdi_writeback *wb)
>  {
>  	return 1;
>  }
>  
> -static inline ino_t __trace_wbc_assign_cgroup(struct writeback_control *wbc)
> +static inline u64 __trace_wbc_assign_cgroup(struct writeback_control *wbc)
>  {
>  	return 1;
>  }
> @@ -192,8 +192,8 @@ TRACE_EVENT(inode_foreign_history,
>  
>  	TP_STRUCT__entry(
>  		__array(char,		name, 32)
> -		__field(ino_t,		ino)
> -		__field(ino_t,		cgroup_ino)
> +		__field(u64,		ino)
> +		__field(u64,		cgroup_ino)
>  		__field(unsigned int,	history)
>  	),
>  
> @@ -204,10 +204,10 @@ TRACE_EVENT(inode_foreign_history,
>  		__entry->history	= history;
>  	),
>  
> -	TP_printk("bdi %s: ino=%lu cgroup_ino=%lu history=0x%x",
> +	TP_printk("bdi %s: ino=%llu cgroup_ino=%llu history=0x%x",
>  		__entry->name,
> -		(unsigned long)__entry->ino,
> -		(unsigned long)__entry->cgroup_ino,
> +		__entry->ino,
> +		__entry->cgroup_ino,
>  		__entry->history
>  	)
>  );
> @@ -221,8 +221,8 @@ TRACE_EVENT(inode_switch_wbs_queue,
>  
>  	TP_STRUCT__entry(
>  		__array(char,		name, 32)
> -		__field(ino_t,		old_cgroup_ino)
> -		__field(ino_t,		new_cgroup_ino)
> +		__field(u64,		old_cgroup_ino)
> +		__field(u64,		new_cgroup_ino)
>  		__field(unsigned int,	count)
>  	),
>  
> @@ -233,10 +233,10 @@ TRACE_EVENT(inode_switch_wbs_queue,
>  		__entry->count		= count;
>  	),
>  
> -	TP_printk("bdi %s: old_cgroup_ino=%lu new_cgroup_ino=%lu count=%u",
> +	TP_printk("bdi %s: old_cgroup_ino=%llu new_cgroup_ino=%llu count=%u",
>  		__entry->name,
> -		(unsigned long)__entry->old_cgroup_ino,
> -		(unsigned long)__entry->new_cgroup_ino,
> +		__entry->old_cgroup_ino,
> +		__entry->new_cgroup_ino,
>  		__entry->count
>  	)
>  );
> @@ -250,9 +250,9 @@ TRACE_EVENT(inode_switch_wbs,
>  
>  	TP_STRUCT__entry(
>  		__array(char,		name, 32)
> -		__field(ino_t,		ino)
> -		__field(ino_t,		old_cgroup_ino)
> -		__field(ino_t,		new_cgroup_ino)
> +		__field(u64,		ino)
> +		__field(u64,		old_cgroup_ino)
> +		__field(u64,		new_cgroup_ino)
>  	),
>  
>  	TP_fast_assign(
> @@ -262,11 +262,11 @@ TRACE_EVENT(inode_switch_wbs,
>  		__entry->new_cgroup_ino	= __trace_wb_assign_cgroup(new_wb);
>  	),
>  
> -	TP_printk("bdi %s: ino=%lu old_cgroup_ino=%lu new_cgroup_ino=%lu",
> +	TP_printk("bdi %s: ino=%llu old_cgroup_ino=%llu new_cgroup_ino=%llu",
>  		__entry->name,
> -		(unsigned long)__entry->ino,
> -		(unsigned long)__entry->old_cgroup_ino,
> -		(unsigned long)__entry->new_cgroup_ino
> +		__entry->ino,
> +		__entry->old_cgroup_ino,
> +		__entry->new_cgroup_ino
>  	)
>  );
>  
> @@ -279,10 +279,10 @@ TRACE_EVENT(track_foreign_dirty,
>  	TP_STRUCT__entry(
>  		__array(char,		name, 32)
>  		__field(u64,		bdi_id)
> -		__field(ino_t,		ino)
> +		__field(u64,		ino)
> +		__field(u64,		cgroup_ino)
> +		__field(u64,		page_cgroup_ino)
>  		__field(unsigned int,	memcg_id)
> -		__field(ino_t,		cgroup_ino)
> -		__field(ino_t,		page_cgroup_ino)
>  	),
>  
>  	TP_fast_assign(
> @@ -297,13 +297,13 @@ TRACE_EVENT(track_foreign_dirty,
>  		__entry->page_cgroup_ino = cgroup_ino(folio_memcg(folio)->css.cgroup);
>  	),
>  
> -	TP_printk("bdi %s[%llu]: ino=%lu memcg_id=%u cgroup_ino=%lu page_cgroup_ino=%lu",
> +	TP_printk("bdi %s[%llu]: ino=%llu memcg_id=%u cgroup_ino=%llu page_cgroup_ino=%llu",
>  		__entry->name,
>  		__entry->bdi_id,
> -		(unsigned long)__entry->ino,
> +		__entry->ino,
>  		__entry->memcg_id,
> -		(unsigned long)__entry->cgroup_ino,
> -		(unsigned long)__entry->page_cgroup_ino
> +		__entry->cgroup_ino,
> +		__entry->page_cgroup_ino
>  	)
>  );
>  
> @@ -316,7 +316,7 @@ TRACE_EVENT(flush_foreign,
>  
>  	TP_STRUCT__entry(
>  		__array(char,		name, 32)
> -		__field(ino_t,		cgroup_ino)
> +		__field(u64,		cgroup_ino)
>  		__field(unsigned int,	frn_bdi_id)
>  		__field(unsigned int,	frn_memcg_id)
>  	),
> @@ -328,9 +328,9 @@ TRACE_EVENT(flush_foreign,
>  		__entry->frn_memcg_id	= frn_memcg_id;
>  	),
>  
> -	TP_printk("bdi %s: cgroup_ino=%lu frn_bdi_id=%u frn_memcg_id=%u",
> +	TP_printk("bdi %s: cgroup_ino=%llu frn_bdi_id=%u frn_memcg_id=%u",
>  		__entry->name,
> -		(unsigned long)__entry->cgroup_ino,
> +		__entry->cgroup_ino,
>  		__entry->frn_bdi_id,
>  		__entry->frn_memcg_id
>  	)
> @@ -345,9 +345,9 @@ DECLARE_EVENT_CLASS(writeback_write_inode_template,
>  
>  	TP_STRUCT__entry (
>  		__array(char, name, 32)
> -		__field(ino_t, ino)
> +		__field(u64, ino)
> +		__field(u64, cgroup_ino)
>  		__field(int, sync_mode)
> -		__field(ino_t, cgroup_ino)
>  	),
>  
>  	TP_fast_assign(
> @@ -358,11 +358,11 @@ DECLARE_EVENT_CLASS(writeback_write_inode_template,
>  		__entry->cgroup_ino	= __trace_wbc_assign_cgroup(wbc);
>  	),
>  
> -	TP_printk("bdi %s: ino=%lu sync_mode=%d cgroup_ino=%lu",
> +	TP_printk("bdi %s: ino=%llu sync_mode=%d cgroup_ino=%llu",
>  		__entry->name,
> -		(unsigned long)__entry->ino,
> +		__entry->ino,
>  		__entry->sync_mode,
> -		(unsigned long)__entry->cgroup_ino
> +		__entry->cgroup_ino
>  	)
>  );
>  
> @@ -385,6 +385,7 @@ DECLARE_EVENT_CLASS(writeback_work_class,
>  	TP_ARGS(wb, work),
>  	TP_STRUCT__entry(
>  		__array(char, name, 32)
> +		__field(u64, cgroup_ino)
>  		__field(long, nr_pages)
>  		__field(dev_t, sb_dev)
>  		__field(int, sync_mode)
> @@ -392,7 +393,6 @@ DECLARE_EVENT_CLASS(writeback_work_class,
>  		__field(int, range_cyclic)
>  		__field(int, for_background)
>  		__field(int, reason)
> -		__field(ino_t, cgroup_ino)
>  	),
>  	TP_fast_assign(
>  		strscpy_pad(__entry->name, bdi_dev_name(wb->bdi), 32);
> @@ -406,7 +406,7 @@ DECLARE_EVENT_CLASS(writeback_work_class,
>  		__entry->cgroup_ino = __trace_wb_assign_cgroup(wb);
>  	),
>  	TP_printk("bdi %s: sb_dev %d:%d nr_pages=%ld sync_mode=%d "
> -		  "kupdate=%d range_cyclic=%d background=%d reason=%s cgroup_ino=%lu",
> +		  "kupdate=%d range_cyclic=%d background=%d reason=%s cgroup_ino=%llu",
>  		  __entry->name,
>  		  MAJOR(__entry->sb_dev), MINOR(__entry->sb_dev),
>  		  __entry->nr_pages,
> @@ -415,7 +415,7 @@ DECLARE_EVENT_CLASS(writeback_work_class,
>  		  __entry->range_cyclic,
>  		  __entry->for_background,
>  		  __print_symbolic(__entry->reason, WB_WORK_REASON),
> -		  (unsigned long)__entry->cgroup_ino
> +		  __entry->cgroup_ino
>  	)
>  );
>  #define DEFINE_WRITEBACK_WORK_EVENT(name) \
> @@ -445,15 +445,15 @@ DECLARE_EVENT_CLASS(writeback_class,
>  	TP_ARGS(wb),
>  	TP_STRUCT__entry(
>  		__array(char, name, 32)
> -		__field(ino_t, cgroup_ino)
> +		__field(u64, cgroup_ino)
>  	),
>  	TP_fast_assign(
>  		strscpy_pad(__entry->name, bdi_dev_name(wb->bdi), 32);
>  		__entry->cgroup_ino = __trace_wb_assign_cgroup(wb);
>  	),
> -	TP_printk("bdi %s: cgroup_ino=%lu",
> +	TP_printk("bdi %s: cgroup_ino=%llu",
>  		  __entry->name,
> -		  (unsigned long)__entry->cgroup_ino
> +		  __entry->cgroup_ino
>  	)
>  );
>  #define DEFINE_WRITEBACK_EVENT(name) \
> @@ -482,15 +482,15 @@ DECLARE_EVENT_CLASS(wbc_class,
>  	TP_ARGS(wbc, bdi),
>  	TP_STRUCT__entry(
>  		__array(char, name, 32)
> +		__field(u64, cgroup_ino)
>  		__field(long, nr_to_write)
>  		__field(long, pages_skipped)
> +		__field(long, range_start)
> +		__field(long, range_end)
>  		__field(int, sync_mode)
>  		__field(int, for_kupdate)
>  		__field(int, for_background)
>  		__field(int, range_cyclic)
> -		__field(long, range_start)
> -		__field(long, range_end)
> -		__field(ino_t, cgroup_ino)
>  	),
>  
>  	TP_fast_assign(
> @@ -507,7 +507,7 @@ DECLARE_EVENT_CLASS(wbc_class,
>  	),
>  
>  	TP_printk("bdi %s: towrt=%ld skip=%ld mode=%d kupd=%d bgrd=%d "
> -		"cyclic=%d start=0x%lx end=0x%lx cgroup_ino=%lu",
> +		"cyclic=%d start=0x%lx end=0x%lx cgroup_ino=%llu",
>  		__entry->name,
>  		__entry->nr_to_write,
>  		__entry->pages_skipped,
> @@ -517,7 +517,7 @@ DECLARE_EVENT_CLASS(wbc_class,
>  		__entry->range_cyclic,
>  		__entry->range_start,
>  		__entry->range_end,
> -		(unsigned long)__entry->cgroup_ino
> +		__entry->cgroup_ino
>  	)
>  )
>  
> @@ -535,11 +535,11 @@ TRACE_EVENT(writeback_queue_io,
>  	TP_ARGS(wb, work, dirtied_before, moved),
>  	TP_STRUCT__entry(
>  		__array(char,		name, 32)
> +		__field(u64,		cgroup_ino)
>  		__field(unsigned long,	older)
>  		__field(long,		age)
>  		__field(int,		moved)
>  		__field(int,		reason)
> -		__field(ino_t,		cgroup_ino)
>  	),
>  	TP_fast_assign(
>  		strscpy_pad(__entry->name, bdi_dev_name(wb->bdi), 32);
> @@ -549,13 +549,13 @@ TRACE_EVENT(writeback_queue_io,
>  		__entry->reason	= work->reason;
>  		__entry->cgroup_ino	= __trace_wb_assign_cgroup(wb);
>  	),
> -	TP_printk("bdi %s: older=%lu age=%ld enqueue=%d reason=%s cgroup_ino=%lu",
> +	TP_printk("bdi %s: older=%lu age=%ld enqueue=%d reason=%s cgroup_ino=%llu",
>  		__entry->name,
>  		__entry->older,	/* dirtied_before in jiffies */
>  		__entry->age,	/* dirtied_before in relative milliseconds */
>  		__entry->moved,
>  		__print_symbolic(__entry->reason, WB_WORK_REASON),
> -		(unsigned long)__entry->cgroup_ino
> +		__entry->cgroup_ino
>  	)
>  );
>  
> @@ -614,13 +614,13 @@ TRACE_EVENT(bdi_dirty_ratelimit,
>  
>  	TP_STRUCT__entry(
>  		__array(char,		bdi, 32)
> +		__field(u64,		cgroup_ino)
>  		__field(unsigned long,	write_bw)
>  		__field(unsigned long,	avg_write_bw)
>  		__field(unsigned long,	dirty_rate)
>  		__field(unsigned long,	dirty_ratelimit)
>  		__field(unsigned long,	task_ratelimit)
>  		__field(unsigned long,	balanced_dirty_ratelimit)
> -		__field(ino_t,		cgroup_ino)
>  	),
>  
>  	TP_fast_assign(
> @@ -638,7 +638,7 @@ TRACE_EVENT(bdi_dirty_ratelimit,
>  	TP_printk("bdi %s: "
>  		  "write_bw=%lu awrite_bw=%lu dirty_rate=%lu "
>  		  "dirty_ratelimit=%lu task_ratelimit=%lu "
> -		  "balanced_dirty_ratelimit=%lu cgroup_ino=%lu",
> +		  "balanced_dirty_ratelimit=%lu cgroup_ino=%llu",
>  		  __entry->bdi,
>  		  __entry->write_bw,		/* write bandwidth */
>  		  __entry->avg_write_bw,	/* avg write bandwidth */
> @@ -646,7 +646,7 @@ TRACE_EVENT(bdi_dirty_ratelimit,
>  		  __entry->dirty_ratelimit,	/* base ratelimit */
>  		  __entry->task_ratelimit, /* ratelimit with position control */
>  		  __entry->balanced_dirty_ratelimit, /* the balanced ratelimit */
> -		  (unsigned long)__entry->cgroup_ino
> +		  __entry->cgroup_ino
>  	)
>  );
>  
> @@ -667,6 +667,7 @@ TRACE_EVENT(balance_dirty_pages,
>  
>  	TP_STRUCT__entry(
>  		__array(	 char,	bdi, 32)
> +		__field(u64,		cgroup_ino)
>  		__field(unsigned long,	limit)
>  		__field(unsigned long,	setpoint)
>  		__field(unsigned long,	dirty)
> @@ -674,13 +675,12 @@ TRACE_EVENT(balance_dirty_pages,
>  		__field(unsigned long,	wb_dirty)
>  		__field(unsigned long,	dirty_ratelimit)
>  		__field(unsigned long,	task_ratelimit)
> -		__field(unsigned int,	dirtied)
> -		__field(unsigned int,	dirtied_pause)
>  		__field(unsigned long,	paused)
>  		__field(	 long,	pause)
>  		__field(unsigned long,	period)
>  		__field(	 long,	think)
> -		__field(ino_t,		cgroup_ino)
> +		__field(unsigned int,	dirtied)
> +		__field(unsigned int,	dirtied_pause)
>  	),
>  
>  	TP_fast_assign(
> @@ -711,7 +711,7 @@ TRACE_EVENT(balance_dirty_pages,
>  		  "wb_setpoint=%lu wb_dirty=%lu "
>  		  "dirty_ratelimit=%lu task_ratelimit=%lu "
>  		  "dirtied=%u dirtied_pause=%u "
> -		  "paused=%lu pause=%ld period=%lu think=%ld cgroup_ino=%lu",
> +		  "paused=%lu pause=%ld period=%lu think=%ld cgroup_ino=%llu",
>  		  __entry->bdi,
>  		  __entry->limit,
>  		  __entry->setpoint,
> @@ -726,7 +726,7 @@ TRACE_EVENT(balance_dirty_pages,
>  		  __entry->pause,	/* ms */
>  		  __entry->period,	/* ms */
>  		  __entry->think,	/* ms */
> -		  (unsigned long)__entry->cgroup_ino
> +		  __entry->cgroup_ino
>  	  )
>  );
>  
> @@ -737,10 +737,10 @@ TRACE_EVENT(writeback_sb_inodes_requeue,
>  
>  	TP_STRUCT__entry(
>  		__array(char, name, 32)
> -		__field(ino_t, ino)
> +		__field(u64, ino)
> +		__field(u64, cgroup_ino)
>  		__field(unsigned long, state)
>  		__field(unsigned long, dirtied_when)
> -		__field(ino_t, cgroup_ino)
>  	),
>  
>  	TP_fast_assign(
> @@ -752,13 +752,13 @@ TRACE_EVENT(writeback_sb_inodes_requeue,
>  		__entry->cgroup_ino	= __trace_wb_assign_cgroup(inode_to_wb(inode));
>  	),
>  
> -	TP_printk("bdi %s: ino=%lu state=%s dirtied_when=%lu age=%lu cgroup_ino=%lu",
> +	TP_printk("bdi %s: ino=%llu state=%s dirtied_when=%lu age=%lu cgroup_ino=%llu",
>  		  __entry->name,
> -		  (unsigned long)__entry->ino,
> +		  __entry->ino,
>  		  show_inode_state(__entry->state),
>  		  __entry->dirtied_when,
>  		  (jiffies - __entry->dirtied_when) / HZ,
> -		  (unsigned long)__entry->cgroup_ino
> +		  __entry->cgroup_ino
>  	)
>  );
>  
> @@ -773,13 +773,13 @@ DECLARE_EVENT_CLASS(writeback_single_inode_template,
>  
>  	TP_STRUCT__entry(
>  		__array(char, name, 32)
> -		__field(ino_t, ino)
> +		__field(u64, ino)
> +		__field(u64, cgroup_ino)
>  		__field(unsigned long, state)
>  		__field(unsigned long, dirtied_when)
>  		__field(unsigned long, writeback_index)
> -		__field(long, nr_to_write)
>  		__field(unsigned long, wrote)
> -		__field(ino_t, cgroup_ino)
> +		__field(long, nr_to_write)
>  	),
>  
>  	TP_fast_assign(
> @@ -794,17 +794,17 @@ DECLARE_EVENT_CLASS(writeback_single_inode_template,
>  		__entry->cgroup_ino	= __trace_wbc_assign_cgroup(wbc);
>  	),
>  
> -	TP_printk("bdi %s: ino=%lu state=%s dirtied_when=%lu age=%lu "
> -		  "index=%lu to_write=%ld wrote=%lu cgroup_ino=%lu",
> +	TP_printk("bdi %s: ino=%llu state=%s dirtied_when=%lu age=%lu "
> +		  "index=%lu to_write=%ld wrote=%lu cgroup_ino=%llu",
>  		  __entry->name,
> -		  (unsigned long)__entry->ino,
> +		  __entry->ino,
>  		  show_inode_state(__entry->state),
>  		  __entry->dirtied_when,
>  		  (jiffies - __entry->dirtied_when) / HZ,
>  		  __entry->writeback_index,
>  		  __entry->nr_to_write,
>  		  __entry->wrote,
> -		  (unsigned long)__entry->cgroup_ino
> +		  __entry->cgroup_ino
>  	)
>  );
>  
> @@ -828,11 +828,11 @@ DECLARE_EVENT_CLASS(writeback_inode_template,
>  	TP_ARGS(inode),
>  
>  	TP_STRUCT__entry(
> -		__field(	dev_t,	dev			)
> -		__field(	ino_t,	ino			)
> +		__field(	u64,	ino			)
>  		__field(unsigned long,	state			)
> -		__field(	__u16, mode			)
>  		__field(unsigned long, dirtied_when		)
> +		__field(	dev_t,	dev			)
> +		__field(	__u16, mode			)
>  	),
>  
>  	TP_fast_assign(
> @@ -843,9 +843,9 @@ DECLARE_EVENT_CLASS(writeback_inode_template,
>  		__entry->dirtied_when = inode->dirtied_when;
>  	),
>  
> -	TP_printk("dev %d,%d ino %lu dirtied %lu state %s mode 0%o",
> +	TP_printk("dev %d,%d ino %llu dirtied %lu state %s mode 0%o",
>  		  MAJOR(__entry->dev), MINOR(__entry->dev),
> -		  (unsigned long)__entry->ino, __entry->dirtied_when,
> +		  __entry->ino, __entry->dirtied_when,
>  		  show_inode_state(__entry->state), __entry->mode)
>  );
>  
> 
> -- 
> 2.53.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
