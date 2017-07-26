From: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH v8 1/1] f2fs: dax: implement direct access
Date: Wed, 26 Jul 2017 12:16:11 -0700
Message-ID: <CAPcyv4hdk8XyYJ5pYvAgUZRoE-SzACNprQm1xaM1KUqBONC8Qw@mail.gmail.com>
References: <1500552639-18523-1-git-send-email-sunqiuyang@huawei.com>
 <CAA9_cmeyVXgu1-ozb7b346ANq+P3e3ATWYfoVGkAKrn5cmo=Hw@mail.gmail.com>
 <20170726072634.GA4684@infradead.org> <CAPcyv4igEW-mFDGywh16QLqywuOusu2u6UboppfzzQ_RRvcgVw@mail.gmail.com>
 <20170726170147.GA31930@infradead.org> <CAPcyv4iNP0qxL5vToffBivkQWyUquD7HrgNmvYXQW9ejhFrAmA@mail.gmail.com>
 <20170726172011.GA30142@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-Reply-To: <20170726172011.GA30142@infradead.org>
Sender: linux-fsdevel-owner@vger.kernel.org
To: Christoph Hellwig <hch@infradead.org>
Cc: "linux-nvdimm@lists.01.org" <linux-nvdimm@ml01.01.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-f2fs-devel@lists.sourceforge.net, linux-fsdevel <linux-fsdevel@vger.kernel.org>, Jaegeuk Kim <jaegeuk@kernel.org>, sunqiuyang <sunqiuyang@huawei.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

On Wed, Jul 26, 2017 at 10:20 AM, Christoph Hellwig <hch@infradead.org> wrote:
> On Wed, Jul 26, 2017 at 10:11:08AM -0700, Dan Williams wrote:
>> Until HMAT came along we had no data in the kernel how to pick a sane
>> default, but we could now very easily make a "if pmem performance <
>> dram, disable dax by default" policy in the kernel.
>
> I'd rather do it the other way around - if HMAT is present and
> pmem performance >= dram use dax.  Else require the explicit -o dax
> for now to enable it.  If an explicit -o nodax is specified disable
> DAX even if HMAT says it is faster.

Silently turn on DAX if HMAT says its ok? I think we would instead
want a "-o autodax" for that case and then "-o dax" and "-o nodax" for
the force cases.

>> The question for this patch is do we want to add yet another
>> filesystem that adds "-o dax" or require use of per-inode flags to
>> enable dax.
>
> Please stick to the mount option.  After spending a lot of time with
> DAX and various memory techologies I'm pretty confident that the inode
> flag is the wrong thing to do.

I think it's easier to administer than the dax mount option. If
someone wants dax on only in a sub-tree they can set the flag on that
parent directory and have a policy in dax filesystems that children
inherit the dax policy from the parent. That seems a better
administrative model than trying to get it all right globally at mount
time.
