From: Jin Qian <jinqian@android.com>
Subject: Re: [PATCHv2 1/1] f2fs: sanity check checkpoint segno and blkoff
Date: Mon, 15 May 2017 10:47:25 -0700
Message-ID: <CA+yUs=zzugeZvDA5TaONpHGhSgMRTQqgMqKjhvu=EKBYa2oUzw@mail.gmail.com>
References: <20170512175040.16387-1-jinqian@android.com> <20170514105131.GA30064@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20170514105131.GA30064@kroah.com>
Sender: stable-owner@vger.kernel.org
To: Greg KH <greg@kroah.com>
Cc: Jin Qian <jinqian@google.com>, linux-f2fs-devel@lists.sourceforge.net, jaegeuk@kernel.org, stable@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

oops, my script added change-Id back. Sent out v3 for correction.

jin

On Sun, May 14, 2017 at 3:51 AM, Greg KH <greg@kroah.com> wrote:
> On Fri, May 12, 2017 at 10:50:40AM -0700, Jin Qian wrote:
>> Make sure segno and blkoff read from raw image are valid.
>>
>> Change-Id: Ia37f5e03aba85f483ddad7a38c64c8e2dbb02243
>
> What is this here for?  That's not really wanted on kernel patches :)
>
> thanks,
>
> greg k-h
