Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 828C5C79F99
	for <linux-f2fs-devel@archiver.kernel.org>; Tue,  8 Sep 2026 18:21:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:Message-Id:Date:References:In-Reply-To:To:From:MIME-Version:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=v/N9dx1QYlhCL3jHPKKTvYHBsX/vUlylb/MS1gcJ5bs=; b=GmiVwwyUnZrSmkePVe41K+N7Y0
	jLYQZTS3AxQpwLgwuQ9yTmojteuLkVhcXmhmfd4AlJkPDHU8UJ7zl83Ba2zyPw9gZ0VL79krLus4Q
	eWStbzJfZpjTqxJHOOww/EFMqlNWKUFYv6R4FpJ5P1mYp3oKpPQx7LgFfVALdfSRXNMM=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1x40RE-0002bx-4L;
	Tue, 08 Sep 2026 18:20:56 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <tz2294@columbia.edu>) id 1x40RC-0002bh-5R
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 08 Sep 2026 18:20:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Message-Id:Date:References:In-Reply-To:Cc:To:From:
 Subject:Content-Transfer-Encoding:Content-Type:MIME-Version:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=FiZbubyoP3HtKI9tuT86fH46V4++xl/Hu2bmom4u9Fc=; b=Fm8jXWYdWLUXGO5HPjyYnXv0KZ
 jWHl0Wp1bncfJSKOfDiMyhP6JSIQhmanL7PUZpU7vt2PXdLxx2lJAkCB53UAtKFmItjkQQSJSz0xl
 THXB5NdYZ7uEH74zNyiGlIbvb88XSeikDUYQ8yilkxvjwb8RmbeSYbRmQV2AmV4PzgHI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ; h=Message-Id:Date:References:In-Reply-To:Cc:To:From:Subject:
 Content-Transfer-Encoding:Content-Type:MIME-Version:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=FiZbubyoP3HtKI9tuT86fH46V4++xl/Hu2bmom4u9Fc=; b=jeu1uVfD9IoOXq7Ki0ZBtyuU4e
 inRmUeGpLuTh4sHHH9TUD8GUDep58gCPFdpxcgnL0ieLlDDVLZzImhn2YEgatXgfU87V80br4WugH
 y1JdIYCajYc6MQT5bpxx9KTMdEt9z1pbIN3t/xbD4fjdx5B/cTNlFlCHtnhn3S2mqZmI=;
Received: from mx0a-00364e01.pphosted.com ([148.163.135.74])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1x40RB-0003cC-6n for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 08 Sep 2026 18:20:54 +0000
Received: from pps.filterd (m0499199.ppops.net [127.0.0.1])
 by mx0a-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 688Hv3F01579864
 for <linux-f2fs-devel@lists.sourceforge.net>; Tue, 8 Sep 2026 14:20:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pps01; bh=FiZb
 ubyoP3HtKI9tuT86fH46V4++xl/Hu2bmom4u9Fc=; b=Ez23U2/Y92kvNjZkkMvv
 Z0de8+cWkmWr0Ru6KQ/R90lpdG3zB1/Vq9ydz5ed/hXdK8TuO/qX0RQWhwriO2ts
 kEFE5uhYhgu4dP5YvFYgK0ce5Fqn3STMa9VW4tkrxu92pr1xNMFBItCleGsIg76E
 MKbqMEc3YS1aqsvMjqDPTe/KY4geTohctvlhV9EalJgYohlfrhhdaqf3+P+3aP9d
 AijG4i6Om5AgOaJeGclSB5CIUSSh8y4dXeZxCgMjW+UvVnOGVifTEEfdAaJhBK6D
 M0UEkg+eM4j6yIZX4LOVV+oRkz47aTFSYh9IcMLv/cMC1qVitVAfxsJPrBsqdlI4
 5w==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69])
 by mx0a-00364e01.pphosted.com (PPS) with ESMTPS id 4gjhqkv775-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 08 Sep 2026 14:20:47 -0400 (EDT)
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-91054f537f9so46328586d6.0
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 08 Sep 2026 11:20:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=columbia.edu; s=lionmail; t=1788891641; x=1789496441;
 darn=lists.sourceforge.net; 
 h=message-id:date:references:in-reply-to:cc:to:from:subject
 :content-transfer-encoding:content-type:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=FiZbubyoP3HtKI9tuT86fH46V4++xl/Hu2bmom4u9Fc=;
 b=S/c75xPlfZpGBq3W7LbQnHPIAAtRYgz/9zuaajYTM7QkRsVFq46FjGZpuV1gcxx5U4
 fbdnXSy01hz2TEZIJfrCRQ8r+HmziY5UKksUjENDfRwTktgO1/MwgGtXDzRwiob0wtUl
 c2f06fapbwnE/Fgwz/3SEB/exC7NNZr9jB9UX52qgPxjybssjmFwGruXDS/RDNVyzUES
 ju/JVF8/jFpFCeuGvR5EBjSXHciBxh1ZQHQ812VMSqOrrnztPi+RqqgI9w+tHyjpvpcV
 EEEq0oORZrUP8cO136QixYrO4YbGR1mtaSFTciqdc5yLn9TyoN/M1kL0Jw3ySpRxE4b+
 0ZEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788891641; x=1789496441;
 h=message-id:date:references:in-reply-to:cc:to:from:subject
 :content-transfer-encoding:content-type:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=FiZbubyoP3HtKI9tuT86fH46V4++xl/Hu2bmom4u9Fc=;
 b=fXXgUda7W3dXKhcGIqx3eJ6+vNNRLRQr4wC7lOJMTIoUAEAK02cN5Rb4SN6Gm+7Boj
 cCoKz1FbXC4jG28ZS6ttAKLxzeSUxoZ1+owqEWKY37Yb9+R8B4/aBrCSR0lFNf8Bpouq
 nckoNlaNq7r3x30P2tIGeGVNEBWFywhERFwgF3BoFrRxKWyBYVAFGqWm0Pdt6XoLBZvA
 CoWosYhTRqU3vuuLqwxGk5XKqiVJYmHSr6Lxmbd8MjH/lYM86BmXCDITMZJlm+vHK7z6
 83nPwREXlQvnueKSgFnt4jkjcfGWrMpQ8a3riXlgNu+afEv8+ApD0xQZ6fknjml7/wTF
 f81A==
X-Forwarded-Encrypted: i=1;
 AKwUvBxr6TVSrsckGKHwg17cftbRKvdbbDg/Us4sQrP8ftLPkQQA4czexoS/5FFW6xioJJYX0arYMnA/8QVfCamcxo/T@lists.sourceforge.net
X-Gm-Message-State: AFuF++lnXSWMHI0sWTtvZEN14BmoDRahPvxXpa6MxQSMJaFlDQgl+uSL
 3xSsUrzsfeQBS3Pp+PBYLIKcsYACEFmbq3LgZyQoP3LKqEmCvQuT/gPy9Vg0A/Gr7FpMm9Aixwl
 llkuw8w8Gmyxy6p5kuZ5B1sxiqCS1UDAv3u3I4lbkRCVNMY6k7gK30Wb78D5Knf/QQoCelj7tDH
 Q=
X-Gm-Gg: AYBFou1v5AK48wS40XZz4YC2FLLxqrkmI00NOWOpGNS3H88DFWvLsROpuc/nJaryjFH
 htJLzcA4558SSddI9GHHNxtqrPVeouTH9U0C7SOZV3flPEDAVhWqXBwyTVC662ynxG7+AoBYVbp
 hQ+3VJ2lx027ylGzMKEK+zyZS7qcjN6EkQOqVdftVwRvzt4E/UzL0r4pxn8tlNXjeMZtdmAaESK
 G4c36iIa5xThobPAsADdX5Tx6MVgkjO/bE9Ojh7qRhnep58J24LzXfZ0VI458lsSkSlmjB0E1lC
 nILVd0tfOf0KHFAo9D081PiuOX84GasThwpebwvPrVFD+j5W9TXEFcsDLRPBdrFc4+E+b4uOBf6
 /78zVTy/79b0YbBnNvgEc+F1p8OkFH1TKhl/Ibpd4kOOkBabB
X-Received: by 2002:a05:6214:130f:b0:8ef:74ad:e62b with SMTP id
 6a1803df08f44-91061f8ef49mr103025506d6.7.1788891641399; 
 Tue, 08 Sep 2026 11:20:41 -0700 (PDT)
X-Received: by 2002:a05:6214:130f:b0:8ef:74ad:e62b with SMTP id
 6a1803df08f44-91061f8ef49mr103024766d6.7.1788891640717; 
 Tue, 08 Sep 2026 11:20:40 -0700 (PDT)
Received: from [127.0.1.1] (nat-128-59-177-174.net.columbia.edu.
 [128.59.177.174]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-9104059559dsm123354136d6.1.2026.09.08.11.20.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Sep 2026 11:20:40 -0700 (PDT)
MIME-Version: 1.0
From: Tal Zussman <tz2294@columbia.edu>
To: "David Hildenbrand (Arm)" <david@kernel.org>
In-Reply-To: <e5792e81-e8a5-42e1-aafe-58dc603f4968@kernel.org>
References: <20260907-remove-pg_private-v3-0-6ae22f9d9272@nvidia.com>
 <20260907-remove-pg_private-v3-6-6ae22f9d9272@nvidia.com>
 <e5792e81-e8a5-42e1-aafe-58dc603f4968@kernel.org>
Date: Tue, 08 Sep 2026 14:20:38 -0400
Message-Id: <178889163877.1334491.3646957026033534678.b4-reply@b4>
X-Mailer: b4 0.17-dev-db0b7
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788891638; l=7108;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=9To4jbmxVaHU3YyuLHtldfm/+1dYUB3KmBeKEkAyIg0=;
 b=dhSBI6ucL59FpBAGiQbj7EbpiPEM0NTxKglQM2e+fxAAMJcz6JHiE6WPjaSAL4vYEtNdtKSfh
 Xc+ZbX2afaGBA+BJy+LCqsbdKeZjC+2iag0hd78rs0jseRBBFMBDBNT
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA4MDE5OSBTYWx0ZWRfX89hNVr79THML
 qXokb7Rcge9j+BwS7BhpoTGtbTtMiqc1N+xweEl7KWlVaHihMC2YPRlWQqbl1PuDXqG7Mxj0sPN
 jQGlVkd+xGywvDbVTwvd0fQnZL4EpWpxzGjg0jyOdn5hfjx1VZY09dN8lvphNf+Ipg+xs9K5Axw
 x/fOkbBo3on/0v2sdf70HWPJ2uNfqFVXziaROuLh54WMaStAZgOlRmBYXjROyq7aZpuyZnYPH75
 9h33L947NKImNha61B6mgOukl3q6K6QAMRok5iQRBPwYayDPnYDYZogffRVSjoRqLFwiVQ9vCNS
 rAUUqJdRPP1MeYgXxI77LCJA9ZJZGqsuNFmLTvFidcTfICvQcQXv8aaSeXp8L17jAdlnY8AEEhP
 zd02XKG7K8ov77Vxic0CK1vhbnSpF1rG64/idnLKW4kgX9fid+iQlK2+y5JzxGlTq+L3aseGQ52
 MLKjWBpSJWMOJ6wSVIQ==
X-Proofpoint-ORIG-GUID: eNd9H-_r7WTQZ1HWo-SfaDPQMQwPRb93
X-Authority-Analysis: v=2.4 cv=CuOPtH4D c=1 sm=1 tr=0 ts=6aa051ff cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=HBUb3goEnnz3w2smY6d+Hw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=x7bEGLp0ZPQA:10 a=A0y_DWxS2BwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=G--0XuH5328wxK7v7Suf:22
 a=VwQbUJbxAAAA:8 a=FP58Ms26AAAA:8 a=Ikd4Dj_1AAAA:8 a=tbrFcHqVj0uyXfjc5ToA:9
 a=QEXdDO2ut3YA:10 a=OIgjcC2v60KrkQgK7BGD:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA4MDE5OSBTYWx0ZWRfX5iBPfeFaTvZE
 BJZxkBkVNiBuAOVFBEMaQ5Zkh4Qb37ShwRISLiVeVJWgM6MF3pJE/uoq+wtqHYQUlD9MOPJ4Q/E
 vqPyzm83+UlYRlKZsE/MF4/Ee6Fktv58ABkKtv72fAg+N/w4QeH2
X-Proofpoint-GUID: eNd9H-_r7WTQZ1HWo-SfaDPQMQwPRb93
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11900
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 lowpriorityscore=10 spamscore=0 bulkscore=10
 clxscore=1015 impostorscore=10 adultscore=0 malwarescore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609080199
X-Headers-End: 1x40RB-0003cC-6n
Subject: Re: [f2fs-dev] [PATCH v3 06/14] f2fs: stop using PG_private
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
Cc: Michal Hocko <mhocko@suse.com>, "Liam R. Howlett" <liam@infradead.org>,
 Jaegeuk Kim <jaegeuk@kernel.org>, Ying Huang <ying.huang@linux.alibaba.com>,
 Qi Zheng <qi.zheng@linux.dev>, Vlastimil Babka <vbabka@kernel.org>,
 Alistair Popple <apopple@nvidia.com>, Dev Jain <dev.jain@arm.com>,
 "Matthew Wilcox \(Oracle\)" <willy@infradead.org>, Zi Yan <ziy@nvidia.com>,
 Gregory Price <gourry@gourry.net>, Ryan Roberts <ryan.roberts@arm.com>,
 Usama Arif <usama.arif@linux.dev>, linux-f2fs-devel@lists.sourceforge.net,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 Shakeel Butt <shakeel.butt@linux.dev>, Lorenzo Stoakes <ljs@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Barry Song <baohua@kernel.org>,
 Kairui Song <kasong@tencent.com>, linux-mm@kvack.org,
 Muchun Song <muchun.song@linux.dev>, linux-kernel@vger.kernel.org,
 Nico Pache <nico.pache@linux.dev>, Lance Yang <lance.yang@linux.dev>,
 Johannes Weiner <hannes@cmpxchg.org>,
 Andrew Morton <akpm@linux-foundation.org>, Mike Rapoport <rppt@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2026-09-08 17:47 +0200, David Hildenbrand (Arm) wrote:
> On 9/8/26 04:56, Zi Yan wrote:
> > f2fs sets its PAGE_PRIVATE_* flags in page->private and checking
> > page->private != NULL is equivalent to checking PG_private. Change
> > PagePrivate() to page_private(). Meanwhile, in set_page_private_##name(),
> > page->private is first set to 0/NULL before an PAGE_PRIVATE_* flag is set,
> > but it can cause confusion when PG_private is removed and
> > page->private != NULL is used instead. Change it to initialize
> > page->private to PAGE_PRIVATE_NOT_POINTER instead and retain the original
> > semantics.
> > 
> > It prepares for a future commit that removes PG_private.
> > 
> > No functional change intended.
> > 
> > Assisted-by: Claude:claude-opus-4-8
> > Assisted-by: Codex:gpt-5
> > To: Jaegeuk Kim <jaegeuk@kernel.org>
> > To: Chao Yu <chao@kernel.org>
> > Cc: linux-f2fs-devel@lists.sourceforge.net
> > Cc: linux-kernel@vger.kernel.org
> > Acked-by: Usama Arif <usama.arif@linux.dev>
> > Acked-by: Chao Yu <chao@kernel.org>
> > Signed-off-by: Zi Yan <ziy@nvidia.com>
> > ---
> >  fs/f2fs/f2fs.h | 8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
> > 
> > diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> > index 9940a6cecf1a2..2f7ab5888b078 100644
> > --- a/fs/f2fs/f2fs.h
> > +++ b/fs/f2fs/f2fs.h
> > @@ -2691,7 +2691,7 @@ static inline bool folio_test_f2fs_##name(const struct folio *folio)	\
> >  }									\
> >  static inline bool page_private_##name(struct page *page) \
> >  { \
> > -	return PagePrivate(page) && \
> > +	return page_private(page) && \
> >  		test_bit(PAGE_PRIVATE_NOT_POINTER, &page_private(page)) && \
> >  		test_bit(PAGE_PRIVATE_##flagname, &page_private(page)); \
> >  }
> > @@ -2710,9 +2710,9 @@ static inline void folio_set_f2fs_##name(struct folio *folio)		\
> >  }									\
> >  static inline void set_page_private_##name(struct page *page) \
> >  { \
> > -	if (!PagePrivate(page)) \
> > -		attach_page_private(page, (void *)0); \
> > -	set_bit(PAGE_PRIVATE_NOT_POINTER, &page_private(page)); \
> > +	if (!page_private(page)) \
> > +		attach_page_private(page, \
> > +				(void *)BIT(PAGE_PRIVATE_NOT_POINTER)); \
> >  	set_bit(PAGE_PRIVATE_##flagname, &page_private(page)); \
> >  }
> 
> Very weird interface. Why do we even need the page-based interface still?
> 
> $ git grep -E "(set|clear)_page_private"
> compress.c:             clear_page_private_gcing(cc->rpages[i]);
> compress.c:                     set_page_private_gcing(cc->rpages[i]);
> compress.c:             clear_page_private_gcing(cic->rpages[i]);
> f2fs.h:static inline void set_page_private_##name(struct page *page) \
> f2fs.h:static inline void clear_page_private_##name(struct page *page) \
> 
> Seeing code like:
> 
> clear_page_private_gcing(cc->rpages[i]);
> if (folio_test_writeback(page_folio(cc->rpages[i])))
> 	end_page_writeback(cc->rpages[i]);
> 
> Makes me wonder whether we can just use the folio helper instead?
> 
> In f2fs_iget(), we enable large folios only when !f2fs_compressed_file(inode).
> 
> So naive me would assume that we can just get rid of the
> set_page_private_/clear_page_private_ stuff entirely.
>

I have a WIP series of ~30 patches converting much of the remaining page
users in f2fs (including the below) to folios. Still have to do some
testing and clean it up, but hoping to send it out in the next couple of
weeks (in the hopes of eliminating some more folio_compat.c functions by
next cycle...)

> IOW something like:
> 
> 
> From efcde918178604de11d16c6dc5485542ab4dcdaf Mon Sep 17 00:00:00 2001
> From: "David Hildenbrand (Arm)" <david@kernel.org>
> Date: Tue, 8 Sep 2026 17:46:06 +0200
> Subject: [PATCH] tmp
> 
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
> ---
>  fs/f2fs/compress.c | 29 ++++++++++++++++++-----------
>  fs/f2fs/f2fs.h     | 13 -------------
>  2 files changed, 18 insertions(+), 24 deletions(-)
> 
> diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
> index ce88092d9ce26..0e9cc0fa297a4 100644
> --- a/fs/f2fs/compress.c
> +++ b/fs/f2fs/compress.c
> @@ -1064,13 +1064,15 @@ static void cancel_cluster_writeback(struct compress_ctx *cc,
>  
>  	/* Cancel writeback and stay locked. */
>  	for (i = 0; i < cc->cluster_size; i++) {
> +		struct folio *folio = page_folio(cc->rpages[i]);
> +
>  		if (i < submitted) {
>  			inode_inc_dirty_pages(cc->inode);
> -			lock_page(cc->rpages[i]);
> +			folio_lock(folio);
>  		}
> -		clear_page_private_gcing(cc->rpages[i]);
> -		if (folio_test_writeback(page_folio(cc->rpages[i])))
> -			end_page_writeback(cc->rpages[i]);
> +		folio_clear_f2fs_gcing(folio);
> +		if (folio_test_writeback(folio))
> +			folio_end_writeback(folio);
>  	}
>  }
>  
> @@ -1078,11 +1080,15 @@ static void set_cluster_dirty(struct compress_ctx *cc)
>  {
>  	int i;
>  
> -	for (i = 0; i < cc->cluster_size; i++)
> -		if (cc->rpages[i]) {
> -			set_page_dirty(cc->rpages[i]);
> -			set_page_private_gcing(cc->rpages[i]);
> -		}
> +	for (i = 0; i < cc->cluster_size; i++) {
> +		struct folio *folio;
> +
> +		if (!cc->rpages[i])
> +			continue;
> +		folio = page_folio(cc->rpages[i]);
> +		folio_mark_dirty(folio);
> +		folio_set_f2fs_gcing(folio);
> +	}
>  }
>  
>  static int prepare_compress_overwrite(struct compress_ctx *cc,
> @@ -1477,8 +1483,9 @@ void f2fs_compress_write_end_io(struct bio *bio, struct folio *folio)
>  
>  	for (i = 0; i < cic->nr_rpages; i++) {
>  		WARN_ON(!cic->rpages[i]);
> -		clear_page_private_gcing(cic->rpages[i]);
> -		end_page_writeback(cic->rpages[i]);
> +		folio = page_folio(cic->rpages[i]);
> +		folio_clear_f2fs_gcing(folio);
> +		folio_end_writeback(folio);
>  	}
>  
>  	page_array_free(sbi, cic->rpages, cic->nr_rpages);
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index 9940a6cecf1a2..0cfba8742d4b4 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -2707,13 +2707,6 @@ static inline void folio_set_f2fs_##name(struct folio *folio)		\
>  		v |= (unsigned long)folio->private;			\
>  		folio->private = (void *)v;				\
>  	}								\
> -}									\
> -static inline void set_page_private_##name(struct page *page) \
> -{ \
> -	if (!PagePrivate(page)) \
> -		attach_page_private(page, (void *)0); \
> -	set_bit(PAGE_PRIVATE_NOT_POINTER, &page_private(page)); \
> -	set_bit(PAGE_PRIVATE_##flagname, &page_private(page)); \
>  }
>  
>  #define PAGE_PRIVATE_CLEAR_FUNC(name, flagname) \
> @@ -2726,12 +2719,6 @@ static inline void folio_clear_f2fs_##name(struct folio *folio)		\
>  		folio_detach_private(folio);				\
>  	else								\
>  		folio->private = (void *)v;				\
> -}									\
> -static inline void clear_page_private_##name(struct page *page) \
> -{ \
> -	clear_bit(PAGE_PRIVATE_##flagname, &page_private(page)); \
> -	if (page_private(page) == BIT(PAGE_PRIVATE_NOT_POINTER)) \
> -		detach_page_private(page); \
>  }
>  
>  PAGE_PRIVATE_GET_FUNC(nonpointer, NOT_POINTER);
> -- 
> 2.43.0
> 
> 
> -- 
> Cheers,
> 
> David
> 




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
