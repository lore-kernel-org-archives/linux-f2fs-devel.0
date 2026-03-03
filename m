Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB0CDEC1431
	for <linux-f2fs-devel@archiver.kernel.org>; Tue,  3 Mar 2026 11:37:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:In-Reply-To:MIME-Version:References:Message-ID:To:From:Date:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5KytxAW1qPhoBtxq6osNS/osP4UKN2X2YgITX7I/sH4=; b=TNheEcw0nwx5r2c2mCWWUXODe7
	Dxj3wfYcmPrdF4fOcwKwCV1fFpGGOwCBJ3Eg+YLvSWDztHqpkdlLKd1z5nDZIfV5bcFyXmBko4AXu
	e2v2I+k9HSnzAkfJiWqb38yHGzHPAa7OdBg9uOaoZT6j5c6nCA3TzlFcT+3GlWd99N98=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1vxO4R-0005rG-HS;
	Tue, 03 Mar 2026 11:37:47 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <jack@suse.cz>) id 1vxO4Q-0005r9-PF
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 03 Mar 2026 11:37:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=KGvY1nGGnAjT98RkQRklRyi1yhpK4+sFFW7EPqGn82U=; b=Q+2SKZZiR7l523J9Ckho52KEHs
 i4y5cbAA2/+J/jWRZo7HDSdZ/omqYfENoSpMh+OQpZcrq22ybIKG7pIY1BNg3q5p7JvfCeAmBmWvB
 Kp40UV67NGOBQkTHGx285aO45UoindOtGly6HojZIMeuze7Iacs00GLCWHGGgP0jDj6k=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=KGvY1nGGnAjT98RkQRklRyi1yhpK4+sFFW7EPqGn82U=; b=SbfudZsQEvjmbKiCvtzBVDk3HU
 nGhyjAvPBLoBmH3eeBzAkJbponYOIdSKZ7CkwWjmYhW8FMf/4bLarRLdQ9ymiseh/QU9A/E1iPNb9
 t+z7QlHkDlFFNaVpZTH0PZK3HQnSkjJt5fEwMTrpbkMGHiLKXIGimiWXo6i5Da6azwLw=;
Received: from smtp-out2.suse.de ([195.135.223.131])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1vxO4O-0004ss-Gx for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 03 Mar 2026 11:37:46 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 2D2035BE0E;
 Tue,  3 Mar 2026 11:37:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1772537858; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KGvY1nGGnAjT98RkQRklRyi1yhpK4+sFFW7EPqGn82U=;
 b=XqVsy1dC2pHASguU1+KG2xYt/C1RmmixP+foKebQnBFh94XXH2eBDNNRgkhBYFosP4SRw0
 Y2V1Hlo/oo9DjO4GgqgbNtsyEvkdAvdbDG01buwc8Mo6oGH3K8WtfzgYTCR9d67SpVFusc
 mYsypXpN4Zztuo2xJNuos8B4YHYRO3Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1772537858;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KGvY1nGGnAjT98RkQRklRyi1yhpK4+sFFW7EPqGn82U=;
 b=nS4StdiCHIdwNQO7HJ67ZmoCUvZNuJFAEH5ylMW56e+tRTkYRzi9O/tibKaBvAnzCAj/jd
 qj0PEnMXcT+Zt+DQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1772537858; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KGvY1nGGnAjT98RkQRklRyi1yhpK4+sFFW7EPqGn82U=;
 b=XqVsy1dC2pHASguU1+KG2xYt/C1RmmixP+foKebQnBFh94XXH2eBDNNRgkhBYFosP4SRw0
 Y2V1Hlo/oo9DjO4GgqgbNtsyEvkdAvdbDG01buwc8Mo6oGH3K8WtfzgYTCR9d67SpVFusc
 mYsypXpN4Zztuo2xJNuos8B4YHYRO3Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1772537858;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KGvY1nGGnAjT98RkQRklRyi1yhpK4+sFFW7EPqGn82U=;
 b=nS4StdiCHIdwNQO7HJ67ZmoCUvZNuJFAEH5ylMW56e+tRTkYRzi9O/tibKaBvAnzCAj/jd
 qj0PEnMXcT+Zt+DQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 169E43EA6D;
 Tue,  3 Mar 2026 11:37:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id Knl6BQLIpml8WAAAD6G6ig
 (envelope-from <jack@suse.cz>); Tue, 03 Mar 2026 11:37:38 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
 id 86E9EA0A1B; Tue,  3 Mar 2026 12:37:29 +0100 (CET)
Date: Tue, 3 Mar 2026 12:37:29 +0100
From: Jan Kara <jack@suse.cz>
To: Jeff Layton <jlayton@kernel.org>
Message-ID: <rallmd55miopcn5jdtzd33ez5udz2haadugzu7vaqxvv2udhje@i73uyn62zwyp>
References: <20260302-iino-u64-v2-0-e5388800dae0@kernel.org>
 <20260302-iino-u64-v2-110-e5388800dae0@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260302-iino-u64-v2-110-e5388800dae0@kernel.org>
X-Spamd-Result: default: False [-0.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 FORGED_RECIPIENTS(2.00)[m:jlayton@kernel.org, m:viro@zeniv.linux.org.uk,
 m:brauner@kernel.org, m:rostedt@goodmis.org, m:mhiramat@kernel.org,
 m:mathieu.desnoyers@efficios.com, m:dan.j.williams@intel.com,
 m:willy@infradead.org, m:ebiggers@kernel.org, m:muchun.song@linux.dev,
 m:david@kernel.org, m:adilger.kernel@dilger.ca, m:jaegeuk@kernel.org,
 m:chao@kernel.org, m:trondmy@kernel.org, m:anna@kernel.org, m:neil@brown.name,
 m:ronniesahlberg@gmail.com, m:alex.aring@gmail.com,
 m:konishi.ryusuke@gmail.com, m:slava@dubeyko.com, m:ericvh@kernel.org,
 m:lucho@ionkov.net, m:asmadeus@codewreck.org, m:linux_oss@crudebyte.com,
 m:marc.dionne@auristor.com, m:luisbg@kernel.org, m:salah.triki@gmail.com,
 m:aivazian.tigran@gmail.com, m:idryomov@gmail.com, m:jaharkes@cs.cmu.edu,
 m:coda@cs.cmu.edu, m:nico@fluxnic.net, m:amir73il@gmail.com,
 m:hch@infradead.org, m:frank.li@vivo.com, m:mikulas@artax.karlin.mff.cuni.cz,
 m:dwmw2@infradead.org, m:shaggy@kernel.org, m:mark@fasheh.com,
 m:jlbec@evilplan.org, m:joseph.qi@linux.alibaba.com, m:al@alarsen.net, 
 m:chengzhihao1@huawei.com, m:dlemoal@kernel.org, m:naohiro.aota@wdc.com,
 m:jth@kernel.org, m:john.johansen@canonical.com, m:serge@hallyn.com,
 m:zohar@linux.ibm.com, m:roberto.sassu@huawei.com, m:dmitry.kasatkin@gmail.com,
 m:wufan@kernel.org, m:stephen.smalley.work@gmail.com,
 m:alexander.deucher@amd.com, m:christian.koenig@amd.com, m:airlied@gmail.com,
 m:simona@ffwll.ch, m:sumit.semwal@linaro.org, m:edumazet@google.com,
 m:kuniyu@google.com, m:willemb@google.com, m:davem@davemloft.net,
 m:kuba@kernel.org, m:horms@kernel.org, m:peterz@infradead.org,
 m:acme@kernel.org, m:namhyung@kernel.org, s:nvdimm@lists.linux.dev,
 s:ocfs2-devel@lists.linux.dev, s:v9fs@lists.linux.dev,
 s:devel@lists.orangefs.org, s:samba-technical@lists.samba.org,
 s:jfs-discussion@lists.sourceforge.net,
 s:linux-f2fs-devel@lists.sourceforge.net, s:apparmor@lists.ubuntu.com,
 s:mkl@pengutronix.de, s:eparis@redhat.com, s:steffen.klassert@secunet.com,
 s:audit@vger.kernel.org, s:autofs@vger.kernel.org, s:bpf@vger.kernel.org,
 s:ceph-devel@vger.kernel.org, s:ecryptf
 s@vger.kernel.org,s:linux-bluetooth@vger.kernel.org,s:linux-can@vger.kernel.org,s:linux-cifs@vger.kernel.org];
 SUSPICIOUS_RECIPS(1.50)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; ARC_NA(0.00)[];
 MISSING_XM_UA(0.00)[]; MIME_TRACE(0.00)[0:+];
 TO_DN_SOME(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 R_RATELIMIT(0.00)[to_ip_from(RLswtmdueuza7a4srcp7atxnzq)];
 URIBL_BLOCKED(0.00)[suse.cz:email,suse.com:email,imap1.dmz-prg2.suse.org:helo];
 FREEMAIL_CC(0.00)[zeniv.linux.org.uk, kernel.org, suse.cz, goodmis.org,
 efficios.com, intel.com, infradead.org, mit.edu, linux.dev, suse.de,
 redhat.com, manguebit.org, dilger.ca, suse.com, oracle.com, brown.name,
 talpey.com, samba.org, gmail.com, microsoft.com, dubeyko.com, ionkov.net,
 codewreck.org, crudebyte.com, auristor.com, themaw.net, cs.cmu.edu,
 fluxnic.net, tyhicks.com, physik.fu-berlin.de, vivo.com,
 artax.karlin.mff.cuni.cz, nod.at, paragon-software.com, fasheh.com,
 evilplan.org, linux.alibaba.com, omnibond.com, szeredi.hu, alarsen.net,
 huawei.com, wdc.com, canonical.com, paul-moore.com, namei.org, hallyn.com,
 linux.ibm.com, schaufler-ca.com, amd.com, ffwll.ch, linaro.org, google.com,
 davemloft.net, arm.com, linux.intel.com, dev.tdt.de, yaina.de, holtmann.org,
 hartkopp.net, pengutronix.de, secunet.com, gondor.apana.org.au, fomichev.me,
 iogearbox.net, vger.kernel.org, lists.linux.dev, kvack.org,
 lists.sourceforge.net, lists.samba.org, lists.infradead.org, coda.cs.cmu.edu,
 lists.orangefs.org, lists.ubuntu.com, lists.freedesktop.org, lists.linaro.or
 g]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 TO_MATCH_ENVRCPT_SOME(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; TAGGED_RCPT(0.00)[];
 RCVD_TLS_LAST(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_GT_50(0.00)[172]; RCVD_COUNT_THREE(0.00)[3];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,imap1.dmz-prg2.suse.org:helo]
X-Headers-End: 1vxO4O-0004ss-Gx
Subject: Re: [f2fs-dev] [PATCH v2 110/110] vfs: remove kino_t typedef and
 PRIino format macro
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
 linux-mtd@lists.infradead.org, amd-gfx@lists.freedesktop.org,
 Marc Dionne <marc.dionne@auristor.com>, Neal Cardwell <ncardwell@google.com>,
 linux-afs@lists.infradead.org, Ian Kent <raven@themaw.net>,
 Naohiro Aota <naohiro.aota@wdc.com>, Eric Biggers <ebiggers@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Miklos Szeredi <miklos@szeredi.hu>,
 Matthew Wilcox <willy@infradead.org>, coda@cs.cmu.edu,
 Stanislav Fomichev <sdf@fomichev.me>, Viacheslav Dubeyko <slava@dubeyko.com>,
 NeilBrown <neil@brown.name>, Ilya Dryomov <idryomov@gmail.com>,
 Paolo Abeni <pabeni@redhat.com>, jfs-discussion@lists.sourceforge.net,
 "Serge E. Hallyn" <serge@hallyn.com>, Amir Goldstein <amir73il@gmail.com>,
 James Clark <james.clark@linaro.org>, autofs@vger.kernel.org,
 Steven Rostedt <rostedt@goodmis.org>, Damien Le Moal <dlemoal@kernel.org>,
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

On Mon 02-03-26 15:25:34, Jeff Layton wrote:
> Now that i_ino has been widened to u64, replace the kino_t typedef with
> u64 and the PRIino format macro with the concrete format strings.
> 
> Replace the remaining PRIino uses throughout the tree, and remove the
> typedef and #define from include/linux/fs.h. Change the i_ino field in
> struct inode from kino_t to u64.
> 
> Signed-off-by: Jeff Layton <jlayton@kernel.org>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/dcache.c        |  4 ++--
>  fs/eventpoll.c     |  2 +-
>  fs/fserror.c       |  2 +-
>  fs/inode.c         | 10 +++++-----
>  fs/locks.c         |  6 +++---
>  fs/nsfs.c          |  4 ++--
>  fs/pipe.c          |  2 +-
>  include/linux/fs.h |  5 +----
>  8 files changed, 16 insertions(+), 19 deletions(-)
> 
> diff --git a/fs/dcache.c b/fs/dcache.c
> index 13fb3e89cba7442c9bed74c41ca18be5e43e28c9..9ceab142896f6631017067890fd1079240448e13 100644
> --- a/fs/dcache.c
> +++ b/fs/dcache.c
> @@ -1637,11 +1637,11 @@ static enum d_walk_ret umount_check(void *_data, struct dentry *dentry)
>  	if (dentry == _data && dentry->d_lockref.count == 1)
>  		return D_WALK_CONTINUE;
>  
> -	WARN(1, "BUG: Dentry %p{i=%" PRIino "x,n=%pd} "
> +	WARN(1, "BUG: Dentry %p{i=%llx,n=%pd} "
>  			" still in use (%d) [unmount of %s %s]\n",
>  		       dentry,
>  		       dentry->d_inode ?
> -		       dentry->d_inode->i_ino : (kino_t)0,
> +		       dentry->d_inode->i_ino : (u64)0,
>  		       dentry,
>  		       dentry->d_lockref.count,
>  		       dentry->d_sb->s_type->name,
> diff --git a/fs/eventpoll.c b/fs/eventpoll.c
> index 90fd92425492221d13bd0cf067d47579bb407a01..4ccd4d2e31adf571f939d2e777123e40302e565f 100644
> --- a/fs/eventpoll.c
> +++ b/fs/eventpoll.c
> @@ -1080,7 +1080,7 @@ static void ep_show_fdinfo(struct seq_file *m, struct file *f)
>  		struct inode *inode = file_inode(epi->ffd.file);
>  
>  		seq_printf(m, "tfd: %8d events: %8x data: %16llx "
> -			   " pos:%lli ino:%" PRIino "x sdev:%x\n",
> +			   " pos:%lli ino:%llx sdev:%x\n",
>  			   epi->ffd.fd, epi->event.events,
>  			   (long long)epi->event.data,
>  			   (long long)epi->ffd.file->f_pos,
> diff --git a/fs/fserror.c b/fs/fserror.c
> index b685b329b5956a639c41b25c42cfff16e6e5ab6e..1e4d11fd9562fd158a23b64ca60e9b7e01719cb8 100644
> --- a/fs/fserror.c
> +++ b/fs/fserror.c
> @@ -176,7 +176,7 @@ void fserror_report(struct super_block *sb, struct inode *inode,
>  lost:
>  	if (inode)
>  		pr_err_ratelimited(
> - "%s: lost file I/O error report for ino %" PRIino "u type %u pos 0x%llx len 0x%llx error %d",
> + "%s: lost file I/O error report for ino %llu type %u pos 0x%llx len 0x%llx error %d",
>  		       sb->s_id, inode->i_ino, type, pos, len, error);
>  	else
>  		pr_err_ratelimited(
> diff --git a/fs/inode.c b/fs/inode.c
> index 24ab9fa10baf7c885244f23bfccd731efe4a14cc..5ad169d51728c260aeaabb810e59eb3ec1d1ce52 100644
> --- a/fs/inode.c
> +++ b/fs/inode.c
> @@ -726,7 +726,7 @@ void dump_mapping(const struct address_space *mapping)
>  	struct dentry *dentry_ptr;
>  	struct dentry dentry;
>  	char fname[64] = {};
> -	kino_t ino;
> +	u64 ino;
>  
>  	/*
>  	 * If mapping is an invalid pointer, we don't want to crash
> @@ -750,14 +750,14 @@ void dump_mapping(const struct address_space *mapping)
>  	}
>  
>  	if (!dentry_first) {
> -		pr_warn("aops:%ps ino:%" PRIino "x\n", a_ops, ino);
> +		pr_warn("aops:%ps ino:%llx\n", a_ops, ino);
>  		return;
>  	}
>  
>  	dentry_ptr = container_of(dentry_first, struct dentry, d_u.d_alias);
>  	if (get_kernel_nofault(dentry, dentry_ptr) ||
>  	    !dentry.d_parent || !dentry.d_name.name) {
> -		pr_warn("aops:%ps ino:%" PRIino "x invalid dentry:%px\n",
> +		pr_warn("aops:%ps ino:%llx invalid dentry:%px\n",
>  				a_ops, ino, dentry_ptr);
>  		return;
>  	}
> @@ -768,7 +768,7 @@ void dump_mapping(const struct address_space *mapping)
>  	 * Even if strncpy_from_kernel_nofault() succeeded,
>  	 * the fname could be unreliable
>  	 */
> -	pr_warn("aops:%ps ino:%" PRIino "x dentry name(?):\"%s\"\n",
> +	pr_warn("aops:%ps ino:%llx dentry name(?):\"%s\"\n",
>  		a_ops, ino, fname);
>  }
>  
> @@ -2641,7 +2641,7 @@ void init_special_inode(struct inode *inode, umode_t mode, dev_t rdev)
>  		/* leave it no_open_fops */
>  		break;
>  	default:
> -		pr_debug("init_special_inode: bogus i_mode (%o) for inode %s:%" PRIino "u\n",
> +		pr_debug("init_special_inode: bogus i_mode (%o) for inode %s:%llu\n",
>  			 mode, inode->i_sb->s_id, inode->i_ino);
>  		break;
>  	}
> diff --git a/fs/locks.c b/fs/locks.c
> index 9c5aa23f09b6e061dc94c81cd802bb65dd0053c1..d8b066fb42108971f6b3c7449dbc9b5f8df16b13 100644
> --- a/fs/locks.c
> +++ b/fs/locks.c
> @@ -234,7 +234,7 @@ locks_check_ctx_lists(struct inode *inode)
>  	if (unlikely(!list_empty(&ctx->flc_flock) ||
>  		     !list_empty(&ctx->flc_posix) ||
>  		     !list_empty(&ctx->flc_lease))) {
> -		pr_warn("Leaked locks on dev=0x%x:0x%x ino=0x%" PRIino "x:\n",
> +		pr_warn("Leaked locks on dev=0x%x:0x%x ino=0x%llx:\n",
>  			MAJOR(inode->i_sb->s_dev), MINOR(inode->i_sb->s_dev),
>  			inode->i_ino);
>  		locks_dump_ctx_list(&ctx->flc_flock, "FLOCK");
> @@ -251,7 +251,7 @@ locks_check_ctx_file_list(struct file *filp, struct list_head *list, char *list_
>  
>  	list_for_each_entry(flc, list, flc_list)
>  		if (flc->flc_file == filp)
> -			pr_warn("Leaked %s lock on dev=0x%x:0x%x ino=0x%" PRIino "x "
> +			pr_warn("Leaked %s lock on dev=0x%x:0x%x ino=0x%llx "
>  				" fl_owner=%p fl_flags=0x%x fl_type=0x%x fl_pid=%u\n",
>  				list_type, MAJOR(inode->i_sb->s_dev),
>  				MINOR(inode->i_sb->s_dev), inode->i_ino,
> @@ -2896,7 +2896,7 @@ static void lock_get_status(struct seq_file *f, struct file_lock_core *flc,
>  			     (type == F_RDLCK) ? "READ" : "UNLCK");
>  	if (inode) {
>  		/* userspace relies on this representation of dev_t */
> -		seq_printf(f, "%d %02x:%02x:%" PRIino "u ", pid,
> +		seq_printf(f, "%d %02x:%02x:%llu ", pid,
>  				MAJOR(inode->i_sb->s_dev),
>  				MINOR(inode->i_sb->s_dev), inode->i_ino);
>  	} else {
> diff --git a/fs/nsfs.c b/fs/nsfs.c
> index 0e099ee2121f8831645c3a25d759793ef2ff9ce6..eac326b85314ac8080248347154d599c953969c7 100644
> --- a/fs/nsfs.c
> +++ b/fs/nsfs.c
> @@ -46,7 +46,7 @@ static char *ns_dname(struct dentry *dentry, char *buffer, int buflen)
>  	struct ns_common *ns = inode->i_private;
>  	const struct proc_ns_operations *ns_ops = ns->ops;
>  
> -	return dynamic_dname(buffer, buflen, "%s:[%" PRIino "u]",
> +	return dynamic_dname(buffer, buflen, "%s:[%llu]",
>  		ns_ops->name, inode->i_ino);
>  }
>  
> @@ -394,7 +394,7 @@ static int nsfs_show_path(struct seq_file *seq, struct dentry *dentry)
>  	const struct ns_common *ns = inode->i_private;
>  	const struct proc_ns_operations *ns_ops = ns->ops;
>  
> -	seq_printf(seq, "%s:[%" PRIino "u]", ns_ops->name, inode->i_ino);
> +	seq_printf(seq, "%s:[%llu]", ns_ops->name, inode->i_ino);
>  	return 0;
>  }
>  
> diff --git a/fs/pipe.c b/fs/pipe.c
> index 311928e8713989747605fd79f653e36d27ce8c0e..9841648c9cf3e8e569cf6ba5c792624fe92396f5 100644
> --- a/fs/pipe.c
> +++ b/fs/pipe.c
> @@ -873,7 +873,7 @@ static struct vfsmount *pipe_mnt __ro_after_init;
>   */
>  static char *pipefs_dname(struct dentry *dentry, char *buffer, int buflen)
>  {
> -	return dynamic_dname(buffer, buflen, "pipe:[%" PRIino "u]",
> +	return dynamic_dname(buffer, buflen, "pipe:[%llu]",
>  				d_inode(dentry)->i_ino);
>  }
>  
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 4193817e02e8bf94f29514ca43379af21f37ac61..097443bf12e289c347651e5f3da5b67eb6b53121 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -758,9 +758,6 @@ struct inode_state_flags {
>  	enum inode_state_flags_enum __state;
>  };
>  
> -typedef u64		kino_t;
> -#define PRIino		"ll"
> -
>  /*
>   * Keep mostly read-only and often accessed (especially for
>   * the RCU path lookup and 'stat' data) fields at the beginning
> @@ -786,7 +783,7 @@ struct inode {
>  #endif
>  
>  	/* Stat data, not accessed from path walking */
> -	kino_t			i_ino;
> +	u64			i_ino;
>  	/*
>  	 * Filesystems may only read i_nlink directly.  They shall use the
>  	 * following functions for modification:
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
