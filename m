From: Christoph Hellwig <hch-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
Subject: Re: [PATCH v8 1/1] f2fs: dax: implement direct access
Date: Wed, 26 Jul 2017 00:26:34 -0700
Message-ID: <20170726072634.GA4684@infradead.org>
References: <1500552639-18523-1-git-send-email-sunqiuyang@huawei.com>
 <CAA9_cmeyVXgu1-ozb7b346ANq+P3e3ATWYfoVGkAKrn5cmo=Hw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAA9_cmeyVXgu1-ozb7b346ANq+P3e3ATWYfoVGkAKrn5cmo=Hw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.01.org/mailman/options/linux-nvdimm>,
 <mailto:linux-nvdimm-request-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.01.org/pipermail/linux-nvdimm/>
List-Post: <mailto:linux-nvdimm-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
List-Help: <mailto:linux-nvdimm-request-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org?subject=help>
List-Subscribe: <https://lists.01.org/mailman/listinfo/linux-nvdimm>,
 <mailto:linux-nvdimm-request-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org?subject=subscribe>
Errors-To: linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
To: Dan Williams <dan.j.williams-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: "linux-nvdimm-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org" <linux-nvdimm-y27Ovi1pjclAfugRpC6u6w@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-f2fs-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-fsdevel <linux-fsdevel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Jaegeuk Kim <jaegeuk-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, sunqiuyang <sunqiuyang-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
List-Id: linux-f2fs-devel.lists.sourceforge.net

On Tue, Jul 25, 2017 at 05:15:10PM -0700, Dan Williams wrote:
> We're in the process of walking back and potentially deprecating the
> use of the dax mount option for xfs and ext4 since dax can have
> negative performance implications if page cache memory happens to be
> faster than pmem. It should be limited to applications that
> specifically want the semantic, not globally enabled for the entire
> mount. xfs has went ahead and added the XFS_DIFLAG2_DAX indoe flag for
> per-inode enabling of dax.
> 
> I'm wondering if any new filesystem that adds dax support at this
> point should do so with inode flags and not a mount option?

That tradeoff is not one that the application should make, but one that
should depend on the storage medium.  To make things worse it might also
depend on the type of access.  E.g. with certain media it makes a lot of
sense to cache writes in the page cache, but generally not reads.
I've been spending some time to analyze how that could be done, but
I've not made real progress on it.

XFS_DIFLAG2_DAX is unfortunately totally unhelpful with that.
