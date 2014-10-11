From: Sasha Levin <sasha.levin@oracle.com>
Subject: Re: [PATCH 3/3] f2fs: refactor flush_nat_entries to
 remove costly reorganizing ops
Date: Sat, 11 Oct 2014 09:11:21 -0400
Message-ID: <54392C79.4010607@oracle.com>
References: <1411447990-37919-1-git-send-email-jaegeuk@kernel.org>
	<1411447990-37919-3-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <sasha.levin@oracle.com>) id 1XcwSP-0004pQ-LH
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 11 Oct 2014 13:11:37 +0000
Received: from aserp1040.oracle.com ([141.146.126.69])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1XcwSO-00068i-QK
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 11 Oct 2014 13:11:37 +0000
In-Reply-To: <1411447990-37919-3-git-send-email-jaegeuk@kernel.org>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

On 09/23/2014 12:53 AM, Jaegeuk Kim wrote:
> +static void __set_nat_cache_dirty(struct f2fs_nm_info *nm_i,
> +						struct nat_entry *ne)
> +{
> +	nid_t set = ne->ni.nid / NAT_ENTRY_PER_BLOCK;
> +	struct nat_entry_set *head;
> +
> +	if (get_nat_flag(ne, IS_DIRTY))
> +		return;
> +retry:
> +	head = radix_tree_lookup(&nm_i->nat_set_root, set);
> +	if (!head) {
> +		head = f2fs_kmem_cache_alloc(nat_entry_set_slab, GFP_ATOMIC);

This is funny, you call f2fs_kmem_cache_alloc() here with GFP_ATOMIC because
of disabled preemption, but f2fs_kmem_cache_alloc() will attempt to
cond_resched() in case of failed allocations:

	retry:
	        entry = kmem_cache_alloc(cachep, flags);
	        if (!entry) {
	                cond_resched();
	                goto retry;
	        }

So in reality, f2fs_kmem_cache_alloc can't really work with GFP_ATOMIC,
and right now there are two different locations that call it with that
flag.


Thanks,
Sasha

------------------------------------------------------------------------------
Meet PCI DSS 3.0 Compliance Requirements with EventLog Analyzer
Achieve PCI DSS 3.0 Compliant Status with Out-of-the-box PCI DSS Reports
Are you Audit-Ready for PCI DSS 3.0 Compliance? Download White paper
Comply to PCI DSS 3.0 Requirement 10 and 11.5 with EventLog Analyzer
http://p.sf.net/sfu/Zoho
